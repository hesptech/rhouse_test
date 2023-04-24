import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FilterProvider extends ChangeNotifier{

  String _filterProvider = Preferences.filtersClassIconsBt == 'residential' ? 'residential' : 'condo' ;
  List<String> _filtersLocation = Preferences.userFiltersCity;
  List<String> _filtersPropertyTypeHouse = Preferences.filtersPropertyTypeHouse;
  List<String> _filtersStyleHouse = Preferences.getfiltersIndexStyleHouse();
  List<String> _filtersStyleCondo = Preferences.getfiltersIndexStyleCondo();
  List<String> _filtersAmmenities = Preferences.getfiltersIndexAmmenities();
  List<String> _filtersBasement = Preferences.getfiltersIndexBasement();

  String get filterProvider {
    return _filterProvider;
  }

  set filterProvider( String value ) {
    _filterProvider = value;
    notifyListeners();
  }

  List<String> get filtersLocation {
    return _filtersLocation;
  }

  set filtersLocation( List<String> value ) {
    _filtersLocation = value;
    notifyListeners();
  }

  List<String> get filtersPropertyTypeHouse {
    return _filtersPropertyTypeHouse;
  }

  set filtersPropertyTypeHouse( List<String> value ) {
    _filtersPropertyTypeHouse = value;
    notifyListeners();
  }

  List<String> get filtersStyleHouse {
    return _filtersStyleHouse;
  }

  set filtersStyleHouse( List<String> value ) {
    _filtersStyleHouse = value;
    notifyListeners();
  }

  List<String> get filtersStyleCondo {
    return _filtersStyleCondo;
  }

  set filtersStyleCondo( List<String> value ) {
    _filtersStyleCondo = value;
    notifyListeners();
  }

  List<String> get filtersBasement {
    return _filtersBasement;
  }

  set filtersBasement( List<String> value ) {
    _filtersBasement = value;
    notifyListeners();
  }

  List<String> get filtersAmmenities {
    return _filtersAmmenities;
  }

  set filtersAmmenities( List<String> value ) {
    _filtersAmmenities = value;
    notifyListeners();
  }
}