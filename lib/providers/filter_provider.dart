import 'package:flutter/material.dart';
//import 'package:flutter_black_white/filters/filters.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FilterProvider extends ChangeNotifier{

  String _filterProvider = Preferences.filtersClassIconsBt == 'residential' ? 'residential' : 'condo' ;
  List<String> _filtersLocation = Preferences.userFiltersCity;
  List<String> _filtersPropertyTypeHouse = Preferences.filtersPropertyTypeHouse;

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
}