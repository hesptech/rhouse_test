
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_black_white/models/models.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';


class RepliersProvider extends ChangeNotifier {

  final String _apiKey = 'AiMUNTXACg2hJOWyy1FJFx4yqtA3Hw';
  final String _baseUrl = 'api.repliers.io';
  String citySearchParam = '';
  List<Listing> onDisplayProperties = [];
  List<Listing> onDisplayHouses = [];
  List<Listing> onDisplayCondo = [];
  List<Listing> onDisplayFilters = [];
  //int _displayPage = 0;
  int _displayPageHouses = 0;
  int _displayPageCondo = 0;
  int _displayPageFilters = 0;


  Map<String, dynamic> filtersResults = {
      'pageNum': '1',
      'resultsPerPage': '15',
      'maxPrice': '2000000',
      'minPrice': '1500000',
      'type': 'sale',
      'hasImages': 'true',
      'class': 'residential',
  };
  Map<String, dynamic> valuesParams = {};


  RepliersProvider( this.citySearchParam ) {
    citySearchParam == 'toronto' ? 'toronto' : citySearchParam ;
    getDisplayHouses();
    getDisplayCondo();
    //getDisplayFilters(filtersResults);
    //getAccessToken();
  }

  Future<String> _getJsonData( String endPoint, String classParam, [int page = 1] ) async {
    final url = Uri.https( _baseUrl, endPoint, {
      'pageNum': '$page',
      'resultsPerPage': '15',
      'maxPrice': '2000000',
      'minPrice': '1500000',
      'type': 'sale',
      'hasImages': 'true',
      'class': classParam,
    });
    //print( 'page: $page' );
    Map<String, String>? headers = { 'REPLIERS-API-KEY': _apiKey };

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: headers);

    if ( response.statusCode == 200 ) {
      return response.body;
    } else {
      return '';
      //print(response.statusCode);
    }
  }

  getDisplayHouses() async {
    _displayPageHouses++;
    final jsonData = await _getJsonData('listings', 'residential', _displayPageHouses); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayHouses = [ ...onDisplayHouses, ...nowPlayingResponse.listings];
    notifyListeners();
  }

  getDisplayCondo() async {
    _displayPageCondo++;
    final jsonData = await _getJsonData('listings', 'condo', _displayPageCondo); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayCondo = [ ...onDisplayCondo, ...nowPlayingResponse.listings];
    notifyListeners();
  }



  // FILTERS
  Future<String> _getJsonDataFilters( String endPoint, Map<String, dynamic> valuesParams, [int page = 1] ) async {
    final url = Uri.https( _baseUrl, endPoint, valuesParams);

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
    notifyListeners();
  }



  // BAD CERTIFICATE solution not in use
  Future getAccessToken() async {
    final url = Uri.https( 'api.repliers.io', 'listings', {
      'page': '1',
      'resultsPerPage': '15',
      'maxPrice': '2000000',
      'minPrice': '1500000',
      'type': 'sale',
      'hasImages': 'true',
      'class': 'condo',
    });

    Map<String, String>? headers = { 'REPLIERS-API-KEY': 'AiMUNTXACg2hJOWyy1FJFx4yqtA3Hw' };

    List<Listing> onDisplayHousesB = [];

    try {
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = IOClient(ioc);
      http.get(url, headers: headers).then(
          (response) {
        //print("Reponse status : ${response.statusCode}");
        //print("Response body : ${response.body}");
        final nowPlayingResponse = ResponseBody.fromJson(response.body);
        //print( nowPlayingResponse.listings[1].mlsNumber );
        onDisplayHousesB = [ ...onDisplayHousesB, ...nowPlayingResponse.listings];
        notifyListeners();
      });
    } catch (e) {
      //print(e.toString());
    }
  }
}