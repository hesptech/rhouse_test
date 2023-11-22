import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RepliersGame extends ChangeNotifier {
  List<Listing> onDisplayGame = [];
  List<String> onDisplayMlsGuesses = [];
  bool isLoading = false;
  bool loaded = false;
  int onCount = 0;

  Future<String> _getJsonMlsGuesses( String endPoint, List valuesParams ) async {
    
    final url = Uri.https( kRhouzeUrl, endPoint, {
      'userId': valuesParams,
    });

    String token = '123456789';
    Map<String, String>? headers = { 'token': token };

    try {
      print(url);
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

  getDisplayMlsGuesses(List mlsGuesses) async {
    final jsonData = await _getJsonMlsGuesses('/rhouze_db/mlsguesses', mlsGuesses);

    final nowDisplayResponse = ResponseMlsGuesses.fromRawJson(jsonData);
    print(nowDisplayResponse.mlsGuesses);

    onDisplayMlsGuesses = [...onDisplayMlsGuesses, ...nowDisplayResponse.mlsGuesses];
  }


  Future<String> _getJsonData( String endPoint, List valuesParams ) async {
    
    valuesParams = ['N7305326','n7274034','w7275236','w7235370','N5632323','N5782890'];
    valuesParams = valuesParams.isEmpty ? ['0'] : valuesParams ;
    
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

  getDisplayGame(List mlsNumbers) async {

    if (isLoading) return;
    isLoading = true;

    final jsonData = await _getJsonData('listings', mlsNumbers); 

    final nowDisplayResponse = ResponseBody.fromJson(jsonData);

    onDisplayGame = [ ...onDisplayGame, ...nowDisplayResponse.listings];
    //print(onDisplayGame[0].mlsNumber);
    onCount = nowDisplayResponse.count;
    loaded = true;
    notifyListeners();
    isLoading = false;
  } 

  initGetDisplay(List mlsNumbers) {

    onDisplayGame = [];
    onCount = 0;
    loaded = false;
    getDisplayGame(mlsNumbers);
    getDisplayMlsGuesses(mlsNumbers);
  }
}