
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_black_white/models/models.dart';


class RepliersProvider extends ChangeNotifier {

  final String _apiKey = 'AiMUNTXACg2hJOWyy1FJFx4yqtA3Hw';
  final String _baseUrl = 'sandbox.repliers.io';
  String citySearchParam = '';
  List<Listing> onDisplayProperties = [];
  List<Listing> onDisplayHouses = [];
  List<Listing> onDisplayCondo = [];
  int _displayPage = 0;

  RepliersProvider( this.citySearchParam ) {
    citySearchParam == 'toronto' ? 'toronto' : citySearchParam ;
    getDisplayHouses();
    getDisplayCondo();
  }

  Future<String> _getJsonData( String endPoint, String classParam, [int page = 1] ) async {
    final url = Uri.https( _baseUrl, endPoint, {
      'page': '$page',
      'resultsPerPage': '15',
      'maxPrice': '2000000',
      'minPrice': '1500000',
      'type': 'sale',
      'hasImages': 'true',
      'class': classParam,
    });

    Map<String, String>? headers = { 'REPLIERS-API-KEY': _apiKey };

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: headers);
    return response.body;
  }

  getDisplayHouses() async {
    _displayPage++;
    final jsonData = await _getJsonData('listings', 'residential', _displayPage); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayHouses = [ ...onDisplayHouses, ...nowPlayingResponse.listings];
    notifyListeners();
  }

  getDisplayCondo() async {
    _displayPage++;
    final jsonData = await _getJsonData('listings', 'condo', _displayPage); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayCondo = [ ...onDisplayCondo, ...nowPlayingResponse.listings];
    notifyListeners();
  }
}