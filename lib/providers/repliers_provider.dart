
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class RepliersProvider extends ChangeNotifier {

  String citySearchParam = '';
  List<String> status;
  String minBeds = '0';
  String maxBeds = '5';
  String minPrice = '500000';
  String maxPrice = '2000000';
  List district = [];
  List<Listing> onDisplayProperties = [];
  List<Listing> onDisplayHouses = [];
  List<Listing> onDisplayCondo = [];
  List<Listing> onDisplayOneBedCondo = [];
  List<Listing> onDisplayTwoBedCondo = [];
  List<Listing> onDisplayCtlTrHouses = [];

  int displayPageHouses = 0;
  int displayPageCondo = 0;
  int displayPageOneBedCondo = 0;
  int displayPageTwoBedCondo = 0;
  int displayPageCtlTrHouses = 0;

  bool isLoadingHouse = false;
  bool isLoadingCondo = false;
  bool isLoadingOneBedCondo = false;
  bool isLoadingTwoBedCondo = false;
  bool isLoadingCtlTrHouses = false;

  DateTime minSoldDate = DateTime.now().subtract(const Duration(days: 365));

  Map<String, dynamic> valuesParams = {};


  RepliersProvider( this.status ) {
    status;
    getDisplayHouses(status);
    getDisplayCondo(status);
    getDisplayOneBedCondo(status);
    getDisplayTwoBedCondo(status);
    getDisplayCtlTrHouses(status);

  }

  Future<String> _getJsonData( String endPoint, String classParam, status, extraParams, [int page = 1] ) async {

    if(extraParams == '1') {
      minBeds = '1';
      maxBeds = '1';
      minPrice = '1';
      maxPrice = '500000';
      district = [];
    } else if (extraParams == '2') {
      minBeds = '2';
      maxBeds = '2';
      minPrice = '1';
      maxPrice = '850000';
      district = [];
    } else if (extraParams == 'CtlTrHouse') {
      minBeds = '0';
      maxBeds = '5';
      minPrice = '1';
      maxPrice = '1400000';
      district = ['Toronto C01','Toronto C02','Toronto C03','Toronto C04','Toronto C06','Toronto C07','Toronto C08','Toronto C09','Toronto C10','Toronto C11','Toronto C13','Toronto C15'];
    } else {
      minBeds = '0';
      maxBeds =  '5';
      minPrice = '1500000';
      maxPrice = '2000000';
      district = [];
    }

    final url = Uri.https( kBaseUrl, endPoint, {
      'pageNum': '$page',
      'resultsPerPage': '15',
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'type': 'sale',
      'hasImages': 'true',
      'class': classParam,
      'status': status,
      'minSoldDate': minSoldDate.toString().substring(0, 10),
      'minBeds': minBeds,
      'maxBeds': maxBeds,
      'district': district
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
    final jsonData = await _getJsonData('listings', 'residential', status, '0', displayPageHouses); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayHouses = [ ...onDisplayHouses, ...nowPlayingResponse.listings];
    notifyListeners();
    isLoadingHouse = false;
  }


  getDisplayCondo(status) async {

    if (isLoadingCondo) return;
    isLoadingCondo = true;

    displayPageCondo++;
    final jsonData = await _getJsonData('listings', 'condo', status, '0', displayPageCondo); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayCondo = [ ...onDisplayCondo, ...nowPlayingResponse.listings];
    notifyListeners();
    isLoadingCondo = false;
  }


  getDisplayOneBedCondo(status) async {

    if (isLoadingOneBedCondo) return;
    isLoadingOneBedCondo = true;

    displayPageOneBedCondo++;
    final jsonData = await _getJsonData('listings', 'condo', status, '1', displayPageOneBedCondo); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayOneBedCondo = [ ...onDisplayOneBedCondo, ...nowPlayingResponse.listings];
    notifyListeners();
    isLoadingOneBedCondo = false;
  }


  getDisplayTwoBedCondo(status) async {

    if (isLoadingTwoBedCondo) return;
    isLoadingTwoBedCondo = true;

    displayPageTwoBedCondo++;
    final jsonData = await _getJsonData('listings', 'condo', status, '2', displayPageTwoBedCondo); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayTwoBedCondo = [ ...onDisplayTwoBedCondo, ...nowPlayingResponse.listings];
    notifyListeners();
    isLoadingTwoBedCondo = false;
  }


  getDisplayCtlTrHouses(status) async {

    if (isLoadingCtlTrHouses) return;
    isLoadingCtlTrHouses = true;

    displayPageCtlTrHouses++;
    final jsonData = await _getJsonData('listings', 'residential', status, 'CtlTrHouse', displayPageCtlTrHouses); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);
    //print(nowPlayingResponse.count);
    onDisplayCtlTrHouses = [ ...onDisplayCtlTrHouses, ...nowPlayingResponse.listings];
    notifyListeners();
    isLoadingCtlTrHouses = false;
  }


  getDisplayHousesStatus(status) async {

    if (isLoadingHouse) return;
    isLoadingHouse = true;

    displayPageHouses = 1;
    final jsonData = await _getJsonData('listings', 'residential', status, '0', displayPageHouses);

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayHouses = nowPlayingResponse.listings;
    notifyListeners();
    isLoadingHouse = false;
  }


  getDisplayCondoStatus(status) async {

    if (isLoadingCondo) return;
    isLoadingCondo = true;

    displayPageCondo = 1;
    final jsonData = await _getJsonData('listings', 'condo', status, '0', displayPageCondo);

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayCondo = nowPlayingResponse.listings;
    notifyListeners();
    isLoadingCondo = false;
  }


  getDisplayOneBedCondoStatus(status) async {

    if (isLoadingOneBedCondo) return;
    isLoadingOneBedCondo = true;

    displayPageOneBedCondo = 1;
    final jsonData = await _getJsonData('listings', 'condo', status, '1', displayPageOneBedCondo);

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayOneBedCondo = nowPlayingResponse.listings;
    notifyListeners();
    isLoadingOneBedCondo = false;
  }


  getDisplayTwoBedCondoStatus(status) async {

    if (isLoadingTwoBedCondo) return;
    isLoadingTwoBedCondo = true;

    displayPageTwoBedCondo = 1;
    final jsonData = await _getJsonData('listings', 'condo', status, '2', displayPageTwoBedCondo);

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayTwoBedCondo = nowPlayingResponse.listings;
    notifyListeners();
    isLoadingTwoBedCondo = false;
  }

  getDisplayCtlTrHousesStatus(status) async {

    if (isLoadingCtlTrHouses) return;
    isLoadingCtlTrHouses = true;

    displayPageCtlTrHouses++;
    final jsonData = await _getJsonData('listings', 'residential', status, 'CtlTrHouse', displayPageCtlTrHouses); 

    final nowPlayingResponse = ResponseBody.fromJson(jsonData);

    onDisplayCtlTrHouses = nowPlayingResponse.listings;
    notifyListeners();
    isLoadingCtlTrHouses = false;
  }


  initGetDisplay(status) {
    displayPageHouses = 1;
    displayPageCondo = 1;
    displayPageOneBedCondo = 1;
    displayPageTwoBedCondo = 1;
    displayPageCtlTrHouses = 1;

    onDisplayHouses = [];
    onDisplayCondo = [];
    onDisplayOneBedCondo = [];
    onDisplayTwoBedCondo = [];
    onDisplayCtlTrHouses = [];

    isLoadingHouse = false;
    isLoadingCondo = false;
    isLoadingOneBedCondo = false;
    isLoadingTwoBedCondo = false;
    isLoadingCtlTrHouses = false;

    getDisplayCondoStatus(status);
    getDisplayHousesStatus(status);
  }
}
