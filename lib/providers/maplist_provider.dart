import 'dart:async';

import 'package:cancellation_token_http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/maps/utils/geolocation_app.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/connectivity_internet.dart';
import 'package:flutter_black_white/utils/filters_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/plugin_api.dart';
// import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
// import 'package:http/http.dart' as http;
import 'package:cancellation_token_http/http.dart' as http;

import 'package:rxdart/subjects.dart';

import '../config/environment.dart';
import '../utils/shared_preferences.dart';

///Provider class providing a list of properties
class MapListProvider extends ChangeNotifier {
  List<Listing> listingSelected = [];
  List<Marker> _selectedCluster = [];
  static bool _loadMap = true;

  late StreamController<List<Listing>> _listingsController;
  late StreamSubscription<List<Listing>> _streamLoop;

  Stream<List<Listing>> get listingStreams => _listingsController.stream;

  initData() {
    listingSelected = [];
    _selectedCluster = [];
    _loadMap = true;
    _flush();
  }

  Future<void> closeAsync() async {
    listingSelected = [];
    _selectedCluster = [];
    loadMap = false;
    await _closeStreams();
  }

  Future<void> closeView() async {
    listingSelected = [];
    _selectedCluster = [];
    loadMap = false;
    _closeStreamsSync();
  }

  String get getApiKey {
    return dotenv.get('API-KEY-MAPTILER');
  }

  bool get loadMap => _loadMap;
  set loadMap(bool value) {
    _loadMap = value;
    notifyListeners();
  }

  List<Marker> get selectedCluster {
    return _selectedCluster;
  }

  set selectedCluster(List<Marker> values) {
    _selectedCluster = values;
    notifyListeners();
  }

  Future<void> getLocationsResidences(LatLng coordinates, CancellationToken tokenHttpCancelation) async {
    if (!await ConnectivityInternet.hasConnection()) {
      return;
    }

    await _getlistingsByRadiusStream('listings', tokenHttpCancelation, coordinates, 200);
  }

  Future<void> _getlistingsByRadiusStream(
    String endPoint,
    CancellationToken tokenHttpCancelation, [
    LatLng? latLng,
    int radius = 0,
  ]) async {
    try {
      int pageListings = 1;
      String envApiKey = dotenv.get('REPLIERS-API-KEY');

      bool isCoordinates = false;
      if (await GeolocationApp.isCheckPermission()) {
        isCoordinates = true;
      }

      ResponseBody bodyResidencesFirst = await _sendRequestListings(pageListings, latLng, radius, envApiKey, endPoint, isCoordinates, tokenHttpCancelation);
      _listingsController.sink.add(bodyResidencesFirst.listings);

      if (_listingsController.isClosed) {
        return;
      }

      if (bodyResidencesFirst.numPages > 1) {
        int totalPages = bodyResidencesFirst.numPages - 1;

        _streamLoop = iterablesPageStreams(totalPages, pageListings, latLng, radius, envApiKey, endPoint, isCoordinates, tokenHttpCancelation).listen((event) {
          if (_listingsController.isClosed) {
            return;
          }
          _listingsController.sink.add(event);
        });
      }

      _streamLoop.onDone(() {
        loadMap = false;
      });
    } catch (_) {
      loadMap = false;
    }
  }

  Future<ResponseBody> _sendRequestListings(
      int pageListings, LatLng? latLng, int radius, String envApiKey, String endPoint, bool isCoordinates, CancellationToken tokenHttpCancelation) async {
    try {
      if (!_loadMap) {
        loadMap = true;
      }

      Map<String, dynamic> filters = {};

      final isFilter = Preferences.isFilter;

      if (isFilter) {
        filters = _getFilters();
      }

      Map<String, dynamic> queryParamsLoop = {
        'pageNum': '$pageListings',
        'resultsPerPage': '800',
        'type': 'sale',
        'hasImages': 'true',
        'fields':
            'details,mlsNumber,class,images,listDate,timestamps,daysOnMarket,listPrice,address,details,map,rooms,lot,taxes,occupancy,nearby,condominium,office,status',
      };

      if (isFilter) {
        queryParamsLoop.addAll(filters);
      } else {
        final Map<String, dynamic> classFilter = {
          'class': ['condo', 'residential'],
        };
        queryParamsLoop.addEntries(classFilter.entries);
      }

      if (isCoordinates) {
        final Map<String, dynamic> coordinates = {
          'lat': '${latLng?.latitude}',
          'long': '${latLng?.longitude}',
          'radius': '$radius',
        };

        queryParamsLoop.addEntries(coordinates.entries);
      } else {
        final Map<String, dynamic> mapCoordinates = {
          'map': '[[[-79.7337553,44.5208101],[-78.3197115,44.3044942],[-79.3180671,43.2184596],[-80.0274040,43.1684845]]]',
        };

        queryParamsLoop.addEntries(mapCoordinates.entries);
      }

      Map<String, String>? headers = {'REPLIERS-API-KEY': envApiKey};

      Map<String, dynamic> params = {"endPoint": endPoint, "queryParams": queryParamsLoop, "headers": headers, "tokenHttpCancelation": tokenHttpCancelation};
      final responseHttp = await compute(getResponse, params);
      final bodyResidences = await compute(processResponse, responseHttp.body);

      return bodyResidences;
    } catch (_) {
      loadMap = false;
      throw Exception("Error");
    }
  }

  Stream<List<Listing>> iterablesPageStreams(int totalPages, int pageListings, LatLng? latLng, int radius, String envApiKey, String endPoint, bool isCoordinates,
      CancellationToken tokenHttpCancelation) async* {
    final listGenerates = List.generate(totalPages, (index) => index);

    try {
      for (var _ in listGenerates) {
        if (_listingsController.isClosed) {
          return;
        }

        pageListings++;
        final responseStream = await _sendRequestListings(pageListings, latLng, radius, envApiKey, endPoint, isCoordinates, tokenHttpCancelation);

        yield responseStream.listings;
      }
    } catch (_) {
      throw Exception("Error");
    }
  }

  static ResponseBody processResponse(String responseString) {
    try {
      return ResponseBody.fromJson(responseString);
    } catch (_) {
      return ResponseBody(page: 0, numPages: 0, pageSize: 0, count: 0, statistics: Statistics(), listings: const []);
    }
  }

  static Future<Response> getResponse(Map<String, dynamic> params) async {
    try {
      String endPoint = params["endPoint"] as String;
      Map<String, dynamic> queryParams = params["queryParams"] as Map<String, dynamic>;
      Map<String, String>? headers = params["headers"] as Map<String, String>?;
      final CancellationToken tokenHttpCancelation = params["tokenHttpCancelation"] as CancellationToken;

      final url = Uri.https(kBaseUrl, endPoint, queryParams);
      final response = await http.get(url, headers: headers, cancellationToken: tokenHttpCancelation);

      return Future.value(response);
    } catch (_) {
      return Future.error("ERROR_CALL");
    }
  }

  void getFilterListings(List<Listing> listingSelectedResult) {
    listingSelected = [];

    listingSelected.addAll(listingSelectedResult);

    notifyListeners();
  }

  Map<String, dynamic> _getFilters() {
    Map<String, dynamic> filtersResults = {};

    var filtersMaps = FiltersPreferences(FilterProvider().filtersPropertyTypeHouse).setFilterQueryParams();

    filtersResults.addAll(filtersMaps);

    return filtersResults;
  }

  _flush() async {
    try {
      _listingsController.close();
    } catch (_) {
      debugPrint("");
    }

    try {
      _streamLoop.cancel();
    } catch (_) {
      debugPrint("");
    }

    try {
      _listingsController = BehaviorSubject<List<Listing>>();
    } catch (_) {
      debugPrint("");
    }
  }

  Future<void> _closeStreams() async {
    try {
      await _listingsController.close();
      await _streamLoop.cancel();
    } catch (_) {}
  }

  Future<void> _closeStreamsSync() async {
    try {
      _listingsController.close();
      _streamLoop.cancel();
    } catch (_) {}
  }
}
