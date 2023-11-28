import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';

class RepliersFavorites extends ChangeNotifier {
  List<Listing> onDisplayFavorites = [];
  List<String> onSelectFavorites = [];
  bool isLoading = false;
  bool loaded = false;
  int onCount = 0;

  Future<String> _getJsonDataSelect( String endPoint, String userId) async {
    userId = userId.isEmpty ? '' : userId ;
    final url = Uri.https( kRhouzeUrl, endPoint, {
      'userid': userId
    });
      String token = '123456789';
    Map<String, String>? headers = { 'token': token };

    try {
      //print(url);
      final response = await http.get(url, headers: headers);
      if(response.statusCode == 200) {
        return response.body;
      } else {
        return processResponse(response);
      }
    } catch (e) {
      return 'Error: $e';
    }
  }


  Future<List<String>> getSelectFavorites(String userId) async {

    final jsonData = await _getJsonDataSelect('/rhouze_db/favorites', userId);

    final selectResponse = ResponseMlsFavorites.fromRawJson(jsonData);

    onSelectFavorites = [];
    for (int i = 0; i < selectResponse.mlsFavorites.length; i++ ) {
      onSelectFavorites.add(selectResponse.mlsFavorites[i]);
    }
    //getDisplayFavorites(onSelectFavorites);
    //print(onSelectFavorites);
    return onSelectFavorites;
  }

  Future<String> _getJsonDataDisplay( String endPoint, List valuesParams ) async {
    
    //valuesParams = onSelectFavorites;
    valuesParams = valuesParams.isEmpty ? ['0'] : valuesParams ;
    //print(valuesParams);
    
    final url = Uri.https( kBaseUrl, endPoint, {
      'mlsNumber': valuesParams,
      'status': ['A','U'],
    });

    String envApiKey = dotenv.get('REPLIERS-API-KEY');
    Map<String, String>? headers = { 'REPLIERS-API-KEY': envApiKey };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        //print(response.body);
        return response.body;
      } else {
        return processResponse(response);
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  getDisplayFavorites(List mlsNumbers) async {

    if (isLoading) return;
    isLoading = true;

    final jsonData = await _getJsonDataDisplay('listings', mlsNumbers); 

    final nowDisplayResponse = ResponseBody.fromJson(jsonData);

    onDisplayFavorites = [ ...onDisplayFavorites, ...nowDisplayResponse.listings];
    onCount = nowDisplayResponse.count;
    loaded = true;
    notifyListeners();
    isLoading = false;
  } 

  initGetDisplay(List mlsNumbers) {
    onDisplayFavorites = [];
    onCount = 0;
    loaded = false;
    getDisplayFavorites(mlsNumbers);
    //getSelectFavorites('1');
  }
}