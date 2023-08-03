
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class RepliersProvider extends ChangeNotifier {

  String citySearchParam = '';
  List<String> status;
  List<Listing> onDisplayProperties = [];
  List<Listing> onDisplayHouses = [];
  List<Listing> onDisplayCondo = [];
  int displayPageHouses = 0;
  int displayPageCondo = 0;
  bool isLoadingHouse = false;
  bool isLoadingCondo = false;
  DateTime minSoldDate = DateTime.now().subtract(const Duration(days: 365));


  Map<String, dynamic> valuesParams = {};


  RepliersProvider( this.status ) {
    status;
    getDisplayHouses(status);
    getDisplayCondo(status);
  }

  Future<String> _getJsonData( String endPoint, String classParam, status, [int page = 1] ) async {
    final url = Uri.https( kBaseUrl, endPoint, {
      'pageNum': '$page',
      'resultsPerPage': '15',
      'maxPrice': '2000000',
      'minPrice': '1500000',
      'type': 'sale',
      'hasImages': 'true',
      'class': classParam,
      'status': status,
      'minSoldDate': minSoldDate.toString().substring(0, 10)
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

  getDisplayHouses(status) async {

    if (isLoadingHouse) return;
    isLoadingHouse = true;

    displayPageHouses++;
    final jsonData = await _getJsonData('listings', 'residential', status, displayPageHouses); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayHouses = [ ...onDisplayHouses, ...nowPlayingResponse.listings];
    notifyListeners();
    isLoadingHouse = false;
  }


  getDisplayCondo(status) async {

    if (isLoadingCondo) return;
    isLoadingCondo = true;

    displayPageCondo++;
    final jsonData = await _getJsonData('listings', 'condo', status, displayPageCondo); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayCondo = [ ...onDisplayCondo, ...nowPlayingResponse.listings];
    notifyListeners();
    isLoadingCondo = false;
  }


  getDisplayHousesStatus(status) async {

    if (isLoadingHouse) return;
    isLoadingHouse = true;

    displayPageHouses = 1;
    final jsonData = await _getJsonData('listings', 'residential', status, displayPageHouses);

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayHouses = nowPlayingResponse.listings;
    notifyListeners();
    isLoadingHouse = false;
  }


  getDisplayCondoStatus(status) async {

    if (isLoadingCondo) return;
    isLoadingCondo = true;

    displayPageCondo = 1;
    final jsonData = await _getJsonData('listings', 'condo', status, displayPageCondo);

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayCondo = nowPlayingResponse.listings;
    notifyListeners();
    isLoadingCondo = false;
  }
}
