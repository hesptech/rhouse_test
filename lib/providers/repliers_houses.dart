import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';


class RepliersHouses extends ChangeNotifier {

  final String _apiKey = 'AiMUNTXACg2hJOWyy1FJFx4yqtA3Hw';
  final String _baseUrl = 'sandbox.repliers.io';
  String citySearchParam = '';
  List<Listing> onDisplayProperties = [];
  int _displayPage = 0;

  RepliersHouses( this.citySearchParam ) {
    citySearchParam == 'toronto' ? 'toronto' : citySearchParam ;
    getDisplayProperties();
  }


  Future<String> _getJsonData( String endPoint, [int page = 1] ) async {
    final url = Uri.https( _baseUrl, endPoint, {
      'page': '$page',
      'resultsPerPage': '15',
      'maxPrice': '2000000',
      'minPrice': '1500000',
      'type': 'sale',
      'hasImages': 'true',
      'class': 'residential',
    });

    Map<String, String>? headers = { 'REPLIERS-API-KEY': _apiKey };

    final response = await http.get(url, headers: headers);
    return response.body;
  }


  getDisplayProperties() async {

    _displayPage++;
    final jsonData = await _getJsonData('listings', _displayPage);

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);
    //print( nowPlayingResponse.listings[1].mlsNumber );

    onDisplayProperties = [ ...onDisplayProperties, ...nowPlayingResponse.listings];
    notifyListeners();
  }
}