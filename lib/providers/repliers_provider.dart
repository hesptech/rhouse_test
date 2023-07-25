
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class RepliersProvider extends ChangeNotifier {

  String citySearchParam = '';
  List<Listing> onDisplayProperties = [];
  List<Listing> onDisplayHouses = [];
  List<Listing> onDisplayCondo = [];
  int _displayPageHouses = 0;
  int _displayPageCondo = 0;
  bool isLoadingHouse = false;
  bool isLoadingCondo = false;


  Map<String, dynamic> valuesParams = {};


  RepliersProvider( this.citySearchParam ) {
    citySearchParam == 'toronto' ? 'toronto' : citySearchParam ;
    getDisplayHouses();
    getDisplayCondo();

  }

  Future<String> _getJsonData( String endPoint, String classParam, [int page = 1] ) async {
    final url = Uri.https( kBaseUrl, endPoint, {
      'pageNum': '$page',
      'resultsPerPage': '15',
      'maxPrice': '2000000',
      'minPrice': '1500000',
      'type': 'sale',
      'hasImages': 'true',
      'class': classParam,
    });
    //print( url );

    String envApiKey = dotenv.get('REPLIERS-API-KEY');

    Map<String, String>? headers = { 'REPLIERS-API-KEY': envApiKey };

    // Await the http get response, then decode the json-formatted response.
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return processResponse(response);
      }
    } catch (e) {
      //print('Error: $e');
      return 'Error: $e';
    }
  }

  getDisplayHouses() async {

    if (isLoadingHouse) return;
    isLoadingHouse = true;

    _displayPageHouses++;
    final jsonData = await _getJsonData('listings', 'residential', _displayPageHouses); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayHouses = [ ...onDisplayHouses, ...nowPlayingResponse.listings];
    notifyListeners();
    isLoadingHouse = false;
  }

  getDisplayCondo() async {

    if (isLoadingCondo) return;
    isLoadingCondo = true;

    _displayPageCondo++;
    final jsonData = await _getJsonData('listings', 'condo', _displayPageCondo); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayCondo = [ ...onDisplayCondo, ...nowPlayingResponse.listings];
    notifyListeners();
    isLoadingCondo = false;
  }
}
