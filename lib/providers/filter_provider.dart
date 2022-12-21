import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FilterProvider extends ChangeNotifier{

  String _filterProvider = Preferences.filtersClassIconsBt == 'residential' ? 'residential' : 'condo' ;

  String get filterProvider {
    return _filterProvider;
  }

  set filterProvider( String value ) {
    _filterProvider = value;
    notifyListeners();
  }
}