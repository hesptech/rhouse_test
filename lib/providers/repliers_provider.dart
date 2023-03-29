
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_black_white/models/models.dart';


class RepliersProvider extends ChangeNotifier {

  final String _apiKey = 'AiMUNTXACg2hJOWyy1FJFx4yqtA3Hw';
  final String _baseUrl = 'api.repliers.io';
  String citySearchParam = '';
  List<Listing> onDisplayProperties = [];
  List<Listing> onDisplayHouses = [];
  List<Listing> onDisplayCondo = [];
  List<Listing> onDisplayFilters = [];


  Map<String, dynamic> valuesParams = {};


  RepliersProvider( this.citySearchParam ) {
    citySearchParam == 'toronto' ? 'toronto' : citySearchParam ;
    getDisplayHouses();
    getDisplayCondo();

  }

  Future<String> _getJsonData( String endPoint, String classParam ) async {
    final url = Uri.https( _baseUrl, endPoint, {
      'hasImages': 'true',
      'class': classParam,
    });
    Map<String, String>? headers = { 'REPLIERS-API-KEY': _apiKey };

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: headers);

    if ( response.statusCode == 200 ) {
      return response.body;
    } else {
      return '';
    }
  }

  getDisplayHouses() async {
    final jsonData = await _getJsonData('listings', 'residential'); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayHouses = [ ...onDisplayHouses, ...nowPlayingResponse.listings];
    notifyListeners();
  }

  getDisplayCondo() async {
    final jsonData = await _getJsonData('listings', 'condo'); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayCondo = [ ...onDisplayCondo, ...nowPlayingResponse.listings];
    notifyListeners();
  }
}