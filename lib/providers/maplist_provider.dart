import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/connectivity_internet.dart';
import 'package:flutter_black_white/utils/filters_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../config/environment.dart';
import '../utils/shared_preferences.dart';

///Provider class providing a list of properties
class MapListProvider extends ChangeNotifier {
  List<Listing> listingSelected = [];
  List<Listing> listingMaps = [];
  List<Marker> _selectedCluster = [];
  bool _disposed = false;
  bool _loadMap = true;

  initData() {
    listingSelected = [];
    listingMaps = [];
    _selectedCluster = [];
    _disposed = false;
    _loadMap = true;
  }

  close() {
    listingSelected = [];
    listingMaps = [];
    _selectedCluster = [];
    _disposed = true;
    _loadMap = false;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  MapListProvider();
  MapListProvider.intiConfig() {
    initData();
  }

  bool get loadMap {
    return _loadMap;
  }

  List<Marker> get selectedCluster {
    return _selectedCluster;
  }

  set selectedCluster(List<Marker> values) {
    _selectedCluster = values;
    notifyListeners();
  }

  String get getApiKey {
    return dotenv.get('API-KEY-MAPTILER');
  }

  Future<void> getLocationsResidences(LatLng coordinates) async {
    initData();
    if (!await ConnectivityInternet.hasConnection()) {
      return;
    }

    await _getlistingsByRadius('listings', coordinates, 200);
  }

  Future<void> _getlistingsByRadius(String endPoint, [LatLng? latLng, int radius = 0]) async {
    try {
      int pageListings = 1;
      String envApiKey = dotenv.get('REPLIERS-API-KEY');
      bool isMorePages = true;

      Map<String, dynamic> queryParamsLoop = {};
      Map<String, dynamic> filters = {};

      var isFilter = Preferences.isFilter;

      if (isFilter) {
        filters = _getFilters();
      }

      while (isMorePages && !_disposed) {
        queryParamsLoop = {
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

        final url = Uri.https(kBaseUrl, endPoint, queryParamsLoop);

        Map<String, String>? headers = {'REPLIERS-API-KEY': envApiKey};

        final response = await http.get(url, headers: headers);

        if (response.statusCode != 200) {
          isMorePages = false;
          break;
        }

        final bodyResidences = await compute((message) {
          return ResponseBody.fromJson(message as String);
        }, response.body);

        var commercials = bodyResidences.listings.where((element) {
          String listingClass = element.listingClass!.toLowerCase();
          return listingClass == "commercial";
        });

        debugPrint("En la pagina $pageListings se encontraron comerciales ${commercials.length}");
        if (pageListings < bodyResidences.numPages) {
          pageListings++;
        } else {
          isMorePages = false;
        }

        listingMaps = bodyResidences.listings;

        notifyListeners();
      }

      _loadMap = false;
      notifyListeners();
    } catch (_) {
      listingMaps = [];
      _loadMap = false;
      notifyListeners();
      return;
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

  ResponseBody _processResponse(Object? data) {
    String response = data as String;
    return ResponseBody.fromJson(response);
  }
}
