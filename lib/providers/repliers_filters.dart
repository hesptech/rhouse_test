//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class RepliersFilters extends ChangeNotifier {

  final String _baseUrl = 'api.repliers.io';
  String citySearchParam = '';
  List<Listing> onDisplayFilters = [];
  int onCount = 0;
  int _displayPageFilters = 0;
  bool loaded = false;


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
    //return response.body;
    if ( response.statusCode == 200 ) {
      return response.body;
    } else {
      return processResponse(response);
    }
  }


  getDisplayFilters(Map<String, dynamic> filtersResults) async {

    _displayPageFilters++;
    filtersResults['pageNum'] = _displayPageFilters.toString(); 

    final jsonData = await _getJsonDataFilters('listings', filtersResults, _displayPageFilters); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayFilters = [ ...onDisplayFilters, ...nowPlayingResponse.listings];
    onCount = nowPlayingResponse.count;
    loaded = true;
    notifyListeners();
  }

  initGetDisplay(Map<String, dynamic> filtersResults) {
    _displayPageFilters = 0;
    onDisplayFilters = [];
    onCount = 0;
    loaded = false;
    getDisplayFilters(filtersResults);
  }
}


String processResponse(Response response) {
  if (response.statusCode == 200 || response.statusCode == 201) {
    return response.body;
  } else if (response.statusCode == 400) {
    throw Exception("Bad request");
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized");
  } else if (response.statusCode == 403) {
    throw Exception("Forbidden");
  } else if (response.statusCode == 404) {
    throw Exception("Not found");
  } else if (response.statusCode == 405) {
    throw Exception("Method not allowed");
  } else if (response.statusCode == 500) {
    throw Exception("Internal server error");
  } else if (response.statusCode == 502) {
    throw Exception("Bad gateway");
  } else if (response.statusCode == 503) {
    throw Exception("Service unavailable");
  } else {
    throw Exception("Unknown response status");
  }
}