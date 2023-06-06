import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/connectivity_internet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../config/environment.dart';
import '../utils/constants.dart';
import '../utils/shared_preferences.dart';

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

  Future<void> getLocationsResidences(bool isFilter, LatLng coordinates) async {
    initData();
    if (!await ConnectivityInternet.hasConnection()) {
      return;
    }

    await _getlistingsByRadius('listings', isFilter, coordinates, 200);
  }

  Future<void> _getlistingsByRadius(String endPoint, bool isFilter, [LatLng? latLng, int radius = 0]) async {
    try {
      int pageListings = 1;
      String envApiKey = dotenv.get('REPLIERS-API-KEY');
      bool isMorePages = true;

      Map<String, dynamic> queryParamsLoop = {};
      Map<String, dynamic> filters = {};

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
              'details,mlsNumber,class,images,listDate,timestamps,daysOnMarket,listPrice,address,details,map,rooms,lot,taxes,occupancy,nearby,condominium,office',
          'lat': '${latLng?.latitude}',
          'long': '${latLng?.longitude}',
          'radius': '$radius'
        };

        if (isFilter) {
          queryParamsLoop.addAll(filters);
        } else {
          queryParamsLoop.addAll({
            'maxPrice': '2000000',
            'minPrice': '1500000',
          });
        }

        final url = Uri.https(kBaseUrl, endPoint, queryParamsLoop);

        Map<String, String>? headers = {'REPLIERS-API-KEY': envApiKey};

        final response = await http.get(url, headers: headers);

        if (response.statusCode != 200) {
          isMorePages = false;
          break;
        }

        final bodyResidences = ResponseBody.fromJson(response.body);

        if (pageListings < bodyResidences.numPages) {
          pageListings++;
        } else {
          isMorePages = false;
        }

        if (isFilter) {
          listingMaps.addAll(bodyResidences.listings);
        } else {
          final listingsFilter = bodyResidences.listings.where((element) {
            String listingClass = element.listingClass!.toLowerCase();
            return listingClass == "residentialproperty" || listingClass == "condoproperty";
          }).toList();

          listingMaps.addAll(listingsFilter);
        }

        notifyListeners();
      }
      
      debugPrint("TOTAL RESIDENCIAS: ${listingMaps.length}");
      _loadMap = false;
      notifyListeners();
    } catch (_) {
      listingMaps = [];
      _loadMap = false;
      notifyListeners();
      return;
    }
  }

  void getFilterListings(List<Marker> mapMarkers) {
    listingSelected = [];

    var keys = mapMarkers.map((marker) => ValueKey(marker.key).value).toSet();

    var filteredListings = listingMaps.where((listing) => keys.contains(Key(listing.mlsNumber!)));

    listingSelected.addAll(filteredListings);

    notifyListeners();
  }

  Map<String, dynamic> _getFilters() {
    Map<String, dynamic> filtersResults = {};
    var labels = kLabels;
    List<String> filterPropertyIcons;
    DateTime todayDate = DateTime.now();

    if (Preferences.filtersClassIconsBt == 'residential') {
      filterPropertyIcons = [
        ...Preferences.filterPropertyIcons,
        ...Preferences.filtersPropertyTypeHouse
      ];
    } else {
      filterPropertyIcons = Preferences.filterPropertyIconsCondo;
    }

    Map<String, dynamic> filtersPrefs = {
      'class': Preferences.filtersClassIconsBt,
      'propertyType': filterPropertyIcons,
      'district': Preferences.userFiltersCity,
    };

    if (int.parse(labels[Preferences.filterPriceRangeStart.round()]) > 1) {
      filtersPrefs['minPrice'] = labels[Preferences.filterPriceRangeStart.round()].toString();
    }

    if (int.parse((labels[Preferences.filterPriceRangeEnd.round()])) <= 4750000) {
      filtersPrefs['maxPrice'] = labels[Preferences.filterPriceRangeEnd.round()].toString();
    }

    if (Preferences.filtersClassIconsBt == 'residential' && Preferences.filtersBedHouse > 1) {
      filtersPrefs['minBeds'] = Preferences.filtersBedHouse.toString();
    }

    if (Preferences.filtersClassIconsBt == 'condo' && Preferences.filtersBedCondo > 0) {
      filtersPrefs['minBeds'] = Preferences.filtersBedCondo.toString();
    }

    if (Preferences.filtersBath > 1) {
      filtersPrefs['minBaths'] = Preferences.filtersBath.toString();
    }

    if (Preferences.filtersClassIconsBt == 'residential' && Preferences.filtersNumParkingSpaces > 0) {
      filtersPrefs['minParkingSpaces'] = Preferences.filtersNumParkingSpaces.toString();
    }

    if (Preferences.filtersClassIconsBt == 'condo' && Preferences.filtersNumParkingSpacesCondos1 == true) {
      filtersPrefs['minParkingSpaces'] = '1';
    }

    if (Preferences.filtersClassIconsBt == 'residential' && Preferences.filtersMinKitchens > 1) {
      filtersPrefs['minKitchens'] = Preferences.filtersMinKitchens.toString();
    }

    DateTime maxListDate = todayDate.subtract(Duration(days: Preferences.filterDaysMarketStart.toInt()));
    filtersPrefs['maxListDate'] = maxListDate.toString().substring(0, 10);

    if (Preferences.filterDaysMarketEnd < 90) {
      DateTime minListDate = todayDate.subtract(Duration(days: Preferences.filterDaysMarketEnd.toInt()));
      filtersPrefs['minListDate'] = minListDate.toString().substring(0, 10);
    }

    if (Preferences.filtersClassIconsBt == 'condo' && Preferences.filtersDen == 'Y') {
      filtersPrefs['den'] = Preferences.filtersDen;
    }

    if (Preferences.filtersClassIconsBt == 'residential') {
      filtersPrefs['style'] = Preferences.getfiltersIndexStyleHouse();
      filtersPrefs['basement'] = Preferences.getfiltersIndexBasement();
    } else {
      filtersPrefs['style'] = Preferences.getfiltersIndexStyleCondo();
    }

    if (Preferences.filtersClassIconsBt == 'residential' && Preferences.getfiltersMaxOpenHouseDate() == true) {
      filtersPrefs['minOpenHouseDate'] = todayDate.toString().substring(0, 10);
    }

    if (Preferences.filtersClassIconsBt == 'residential' && Preferences.getfiltersIndexSwimmingPool().isNotEmpty) {
      filtersPrefs['swimmingPool'] = Preferences.getfiltersIndexSwimmingPool();
    }

    if (Preferences.filtersClassIconsBt == 'condo' && Preferences.filterSizeStart > 10) {
      filtersPrefs['minSqft'] = Preferences.filterSizeStart.round().toString();
    }

    if (Preferences.filtersClassIconsBt == 'condo' && Preferences.filterSizeEnd < 2999) {
      filtersPrefs['maxSqft'] = Preferences.filterSizeEnd.round().toString();
    }

    if (Preferences.filtersClassIconsBt == 'condo' && Preferences.filterCondoFeeEnd < 1500) {
      filtersPrefs['maxMaintenanceFee'] = Preferences.filterCondoFeeEnd.round().toString();
    }

    if (Preferences.filtersClassIconsBt == 'condo') {
      filtersPrefs['amenities'] = Preferences.getfiltersIndexAmmenities();
    }

    filtersResults.addAll(filtersPrefs);

    return filtersResults;
  }
}
