
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class RepliersProvider extends ChangeNotifier {

  final String _baseUrl = 'api.repliers.io';
  String citySearchParam = '';
  List<Listing> onDisplayProperties = [];
  List<Listing> onDisplayHouses = [];
  List<Listing> onDisplayCondo = [];
  int _displayPageHouses = 0;
  int _displayPageCondo = 0;


  Map<String, dynamic> valuesParams = {};


  RepliersProvider( this.citySearchParam ) {
    citySearchParam == 'toronto' ? 'toronto' : citySearchParam ;
    getDisplayHouses();
    getDisplayCondo();

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

    String envApiKey = dotenv.get('REPLIERS-API-KEY');

    Map<String, String>? headers = { 'REPLIERS-API-KEY': envApiKey };

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: headers);

    if ( response.statusCode == 200 ) {
      return response.body;
    } else {
      return '';
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
}