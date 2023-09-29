import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/config/filters_data_locations.dart';

class FilterProvider extends ChangeNotifier {

  String _filterProvider = Preferences.filtersClassIconsBt == 'residential' ? 'residential' : 'condo';
  List<String> _filtersLocationTopbts = Preferences.filtersLocationTopbts;
  List<String> _filtersLocation = Preferences.userFiltersCity;
  List<String> _filtersPropertyTypeHouse = Preferences.filtersPropertyTypeHouse;
  List<String> _filtersStyleHouse = Preferences.getfiltersIndexStyleHouse();
  List<String> _filtersStyleCondo = Preferences.getfiltersIndexStyleCondo();
  List<String> _filtersAmmenities = Preferences.getfiltersIndexAmmenities();
  List<String> _filtersBasement = Preferences.getfiltersIndexBasement();
  List<String> _filtersStatusProperties = Preferences.filtersStatusProperties;

  String get filterProvider {
    return _filterProvider;
  }

  set filterProvider(String value) {
    _filterProvider = value;
    notifyListeners();
  }

  List<String> get filtersLocation {
    return _filtersLocation;
  }

  set filtersLocation(List<String> value) {
    _filtersLocation = value;
    notifyListeners();
  }

  List<String> get filtersLocationTopbts {
    return _filtersLocationTopbts;
  }

  set filtersLocationTopbts( List<String> value ) {
    _filtersLocationTopbts = value;
    notifyListeners();
  }

  List<String> get filtersPropertyTypeHouse {
    return _filtersPropertyTypeHouse;
  }

  set filtersPropertyTypeHouse(List<String> value) {
    _filtersPropertyTypeHouse = value;
    notifyListeners();
  }

  List<String> get filtersStyleHouse {
    return _filtersStyleHouse;
  }

  set filtersStyleHouse(List<String> value) {
    _filtersStyleHouse = value;
    notifyListeners();
  }

  List<String> get filtersStyleCondo {
    return _filtersStyleCondo;
  }

  set filtersStyleCondo(List<String> value) {
    _filtersStyleCondo = value;
    notifyListeners();
  }

  List<String> get filtersBasement {
    return _filtersBasement;
  }

  set filtersBasement(List<String> value) {
    _filtersBasement = value;
    notifyListeners();
  }

  List<String> get filtersAmmenities {
    return _filtersAmmenities;
  }

  set filtersAmmenities(List<String> value) {
    _filtersAmmenities = value;
    notifyListeners();
  }

  List<String> get filtersStatusProperties {
    return _filtersStatusProperties;
  }

  set filtersStatusProperties( List<String> value ) {
    _filtersStatusProperties = value;
    notifyListeners();
  }

  void cleanFilter() {
    Preferences.filterPriceRangeStart = 9.0;
    Preferences.filterPriceRangeEnd = 28.0;
    Preferences.filtersClassIconsBt = 'residential';
    Preferences.filterPropertyIcons = [];
    Preferences.filterPropertyIconsCondo = [];
    Preferences.filterPropertyType = [];

    Preferences.filtersLocationTopbts = [];
    Preferences.filtersTrCentral = [];
    Preferences.filtersTrEast = [];
    Preferences.filtersTrWest = [];
    Preferences.filtersGtaWest = [];
    Preferences.filtersGtaNorth = [];
    Preferences.filtersGtaEast = [];
    Preferences.filtersOther = [];

    Preferences.filtersBedHouse = 1;
    Preferences.filtersBedCondo = 0;
    Preferences.filtersDen = 'N';
    Preferences.filtersBath = 1;
    Preferences.filtersNumParkingSpaces = 0;
    Preferences.filtersNumParkingSpacesCondos = 0;
    Preferences.filtersNumParkingSpacesCondos1 = false;
    Preferences.filtersMinKitchens = 1;

    Preferences.filtersStyleHouse = [];
    Preferences.filtersStyleCondo = [];
    Preferences.filtersBasement = [];
    Preferences.filtersAmmenities = [];
    Preferences.setfiltersMaxOpenHouseDate(false);
    Preferences.setfiltersIndexSwimmingPool([]);

    Preferences.filterDaysMarketStart = 0.0;
    Preferences.filterDaysMarketEnd = 30.0;
    Preferences.filterSizeStart = 10.0;
    Preferences.filterSizeEnd = 3000.0;
    Preferences.filterCondoFeeStart = 100.0;
    Preferences.filterCondoFeeEnd = 1500.0;
    Preferences.filtersCondoExtra = [];

    Preferences.filtersPropertyTypeHouse = [];
    Preferences.userFiltersCity = [];
    Preferences.setfiltersIndexStyleHouse([]);
    Preferences.setfiltersIndexStyleCondo([]);
    Preferences.setfiltersIndexBasement([]);
    Preferences.setfiltersIndexAmmenities([]);
    Preferences.isFilter = false;
    Preferences.isCleanFilter = true;
  }

  void resetLocationsOnly() {
    Preferences.filtersTrCentral = [];
    Preferences.filtersTrEast = [];
    Preferences.filtersTrWest = [];
    Preferences.filtersGtaWest = [];
    Preferences.filtersGtaNorth = [];
    Preferences.filtersGtaEast = [];
    Preferences.filtersOther = [];  
  }

 void resetLocationTopbts() {
    if (Preferences.filtersLocationTopbts.contains('TORONTO') || Preferences.filtersLocationTopbts.contains('Suburbs - Outskirts')) {
      _filtersLocationTopbts = [];

      List propertiesLocationTopbtsKey = [];
      List<List<String>> propertiesLocationTopbtsValue = [];

      locationTopbt.forEach( (key, value) {
        propertiesLocationTopbtsKey.add(key);
      });

      locationTopbt.forEach( (key, value) {
        propertiesLocationTopbtsValue.add(value);
      });

      for (var element in propertiesLocationTopbtsKey) {

        for(int i = 0; i < propertiesLocationTopbtsValue[propertiesLocationTopbtsKey.indexOf(element)].length; ++i){
          if(Preferences.userFiltersCity.contains(propertiesLocationTopbtsValue[propertiesLocationTopbtsKey.indexOf(element)][i])){
            Preferences.userFiltersCity.removeWhere((String name) => name == propertiesLocationTopbtsValue[propertiesLocationTopbtsKey.indexOf(element)][i]);
            filtersLocation.removeWhere((String name) => name == propertiesLocationTopbtsValue[propertiesLocationTopbtsKey.indexOf(element)][i]);

            //print(propertiesLocationTopbtsValue[propertiesLocationTopbtsKey.indexOf(element)][i]);
          }
        } 
      } 

      Preferences.filtersLocationTopbts = [];

      //print(filtersLocationTopbts); 
      //print('one or other');
    } else {
      //print('NONE');
    }
    //notifyListeners();
  }
}
