//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;


class RepliersFilters extends ChangeNotifier {

  final String _apiKey = 'AiMUNTXACg2hJOWyy1FJFx4yqtA3Hw';
  final String _baseUrl = 'api.repliers.io';
  String citySearchParam = '';
  List<Listing> onDisplayFilters = [];
  int onCount = 0;
  int _displayPageFilters = 0;

  Map<String, dynamic> filtersResultsOff = {
      'pageNum': '1',
      'resultsPerPage': '15',
      'maxPrice': '2000000',
      'minPrice': '1500000',
      'type': 'sale',
      'hasImages': 'true',
      'class': Preferences.filtersClassIconsBt,
  };


  RepliersFilters( this.citySearchParam ) {
    citySearchParam == 'toronto' ? 'toronto' : citySearchParam ;
    //getDisplayFilters(filtersResults);
  }

  // FILTERS
  Future<String> _getJsonDataFilters( String endPoint, Map<String, dynamic> valuesParams, [int page = 1] ) async {
    //endPoint = 'listings?pageNum=1&resultsPerPage=15&maxPrice=2500000&minPrice=1500000&type=sale&hasImages=true';
    final url = Uri.https( _baseUrl, endPoint, valuesParams);
    print( url );
    Map<String, String>? headers = { 'REPLIERS-API-KEY': _apiKey };

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: headers);
    return response.body;
  }

  // getDisplayFilters(Map<String, dynamic> filtersAdditions) async {
  getDisplayFilters(Map<String, dynamic> filtersResults) async {

    _displayPageFilters++;
    filtersResults['pageNum'] = _displayPageFilters.toString(); 
    //print(filtersResults);
    //print(Preferences.filtersClassIconsBt);
    final jsonData = await _getJsonDataFilters('listings', filtersResults, _displayPageFilters); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayFilters = [ ...onDisplayFilters, ...nowPlayingResponse.listings];
    onCount = nowPlayingResponse.count;
    notifyListeners();
  }

  initGetDisplay(Map<String, dynamic> filtersResults) {
    _displayPageFilters = 0;
    onDisplayFilters = [];
    onCount = 0;
    //print(filtersResults);
    getDisplayFilters(filtersResults);
  }
}