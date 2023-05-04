//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:http/http.dart' as http;


class RepliersFilters extends ChangeNotifier {

  final String _baseUrl = 'api.repliers.io';
  String citySearchParam = '';
  List<Listing> onDisplayFilters = [];
  int onCount = 0;
  int _displayPageFilters = 0;


  RepliersFilters( this.citySearchParam ) {
    citySearchParam == 'toronto' ? 'toronto' : citySearchParam ;
  }

  // FILTERS
  Future<String> _getJsonDataFilters( String endPoint, Map<String, dynamic> valuesParams, [int page = 1] ) async {
    endPoint = 'listings';
    final url = Uri.https( _baseUrl, endPoint, valuesParams);
    //print( url );

    String envApiKey = dotenv.get('REPLIERS-API-KEY');

    Map<String, String>? headers = { 'REPLIERS-API-KEY': envApiKey };

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: headers);
    return response.body;
  }


  getDisplayFilters(Map<String, dynamic> filtersResults) async {

    _displayPageFilters++;
    filtersResults['pageNum'] = _displayPageFilters.toString(); 

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
    getDisplayFilters(filtersResults);
  }
}