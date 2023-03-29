//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:http/http.dart' as http;


class RepliersFilters extends ChangeNotifier {

  final String _apiKey = 'AiMUNTXACg2hJOWyy1FJFx4yqtA3Hw';
  final String _baseUrl = 'api.repliers.io';
  String citySearchParam = '';
  List<Listing> onDisplayFilters = [];


  RepliersFilters( this.citySearchParam ) {
    citySearchParam == 'toronto' ? 'toronto' : citySearchParam ;
  }

  // FILTERS
  Future<String> _getJsonDataFilters( String endPoint,  ) async {
    endPoint = 'listings';
    final url = Uri.https( _baseUrl, endPoint, {
      'hasImages': 'true',
    });

    Map<String, String>? headers = { 'REPLIERS-API-KEY': _apiKey };

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: headers);
    return response.body;
  }


  getDisplayFilters(Map<String, dynamic> filtersResults) async {

    final jsonData = await _getJsonDataFilters('listings'); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayFilters = [ ...onDisplayFilters, ...nowPlayingResponse.listings];
    notifyListeners();
  }

  initGetDisplay(Map<String, dynamic> filtersResults) {
    onDisplayFilters = [];
    getDisplayFilters(filtersResults);
  }
}