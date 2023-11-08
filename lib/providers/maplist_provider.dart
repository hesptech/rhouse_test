import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/connectivity_internet.dart';
import 'package:flutter_black_white/utils/filters_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../config/environment.dart';
import '../utils/shared_preferences.dart';

///Provider class providing a list of properties
class MapListProvider extends ChangeNotifier {
  List<Listing> listingSelected = [];
  List<Marker> _selectedCluster = [];
  bool _loadMap = true;

  bool get loadMap => _loadMap;

  set loadMap(bool value) {
    _loadMap = value;
    notifyListeners();
  }

  bool loadView = false;

  StreamController<List<Listing>> _listingsController = StreamController<List<Listing>>.broadcast();

  Stream<List<Listing>> get listingStreams => _listingsController.stream;
  late StreamSubscription<List<Listing>> _streamLoop;

  initData() {
    listingSelected = [];
    _selectedCluster = [];
    _loadMap = true;
    loadView = true;
    _flush();
  }

  close() async {
    listingSelected = [];
    _selectedCluster = [];
    _loadMap = false;
    _closeStreams();
  }

  MapListProvider();

  List<Marker> get selectedCluster {
    return _selectedCluster;
  }

  set selectedCluster(List<Marker> values) {
    _selectedCluster = values;
    notifyListeners();
  }

  bool get getLoadView => loadView;

  set setLoadView(bool loadView) {
    loadView = loadView;
    notifyListeners();
  }

  String get getApiKey {
    return dotenv.get('API-KEY-MAPTILER');
  }

  Future<void> getLocationsResidences(LatLng coordinates) async {
    if (!await ConnectivityInternet.hasConnection()) {
      return;
    }

    await _getlistingsByRadiusStream('listings', coordinates, 200);
  }

  Future<void> _getlistingsByRadiusStream(String endPoint, [LatLng? latLng, int radius = 0]) async {
    try {
      int pageListings = 1;
      String envApiKey = dotenv.get('REPLIERS-API-KEY');

      ResponseBody bodyResidencesFirst = await _sendRequestListings(pageListings, latLng, radius, envApiKey, endPoint);
      _listingsController.sink.add(bodyResidencesFirst.listings);

      if (bodyResidencesFirst.numPages > 1) {
        int totalPages = bodyResidencesFirst.numPages - 1;

        _streamLoop = iterablesPageStreams(totalPages, pageListings, latLng, radius, envApiKey, endPoint).listen((event) {
          if (_listingsController.isClosed) {
            return;
          }
          _listingsController.sink.add(event);
        });
      }
    } catch (_) {}
  }

  Future<ResponseBody> _sendRequestListings(int pageListings, LatLng? latLng, int radius, String envApiKey, String endPoint) async {
    try {
      Map<String, dynamic> filters = {};

      var isFilter = Preferences.isFilter;

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
        'lat': '${latLng?.latitude}',
        'long': '${latLng?.longitude}',
        'radius': '$radius',
        'class': ['condo', 'residential'],
      };

      if (isFilter) {
        queryParamsLoop.addAll(filters);
      }

      Map<String, String>? headers = {'REPLIERS-API-KEY': envApiKey};

      Map<String, dynamic> params = {"endPoint": endPoint, "queryParams": queryParamsLoop, "headers": headers};
      final responseHttp = await compute(getResponse, params);
      final bodyResidences = await compute(processResponse, responseHttp.body);
      return bodyResidences;
    } catch (_) {
      return ResponseBody(page: 0, numPages: 0, pageSize: 0, count: 0, statistics: Statistics(), listings: const []);
    }
  }

  Stream<List<Listing>> iterablesPageStreams(int totalPages, int pageListings, LatLng? latLng, int radius, String envApiKey, String endPoint) async* {
    var listGenerates = List.generate(totalPages, (index) => index);

    for (var _ in listGenerates) {
      pageListings++;
      var responseStream = await _sendRequestListings(pageListings, latLng, radius, envApiKey, endPoint);

      if (pageListings == responseStream.numPages) {
        loadMap = false;
      }

      yield responseStream.listings;
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

      final url = Uri.https(kBaseUrl, endPoint, queryParams);
      final response = await http.get(url, headers: headers);

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

  _flush() {
    try {
      _listingsController.close();
      _listingsController = StreamController<List<Listing>>.broadcast();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _closeStreams() {
    try {
      _listingsController.close();
      _streamLoop.cancel();
    } catch (_) {
      
    }
  }
}
