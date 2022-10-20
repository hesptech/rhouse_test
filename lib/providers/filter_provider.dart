import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier{

  String _filterProvider = 'pippo';

  String get filterProvider {
    return _filterProvider;
  }

  set filterProvider( String value ) {
    _filterProvider = value;
    notifyListeners();
  }
}