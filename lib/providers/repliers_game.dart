import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';

class RepliersGame extends ChangeNotifier {
  List<Listing> onDisplayGame = [];
  List<String> onSelectGame = [];
  List<String> onInsertGame = [];
  List<String> onDeleteGame = [];
  bool isLoading = false;
  bool loaded = false;
  int onCount = 0;

  /// SELECT
  Future<String> _getJsonDataSelect( String endPoint, String userId ) async {
    
    final url = Uri.https( kRhouzeUrl, endPoint, {
      'mlsselect': '1',
      'mlsuserid': userId,
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

  getSelectGame(String userId) async {
    final jsonData = await _getJsonDataSelect('/rhouze_db/game', userId);

    final nowDisplayResponse = ResponseMlsGame.fromRawJson(jsonData);
    //print(nowDisplayResponse.mlsGame);   

    onSelectGame = [];
    List<String> tempMlsList = [];
    for (int i = 0; i < nowDisplayResponse.mlsGame.length; i++) {    
      tempMlsList = nowDisplayResponse.mlsGame[i].split('-');
      onSelectGame.add(tempMlsList[0]);
      //mlsGamePrice[tempMlsList[0]] = tempMlsList[1]; 
    }
    //print(onSelectGame);

    Map<String, String> map1 = { for (var e in nowDisplayResponse.mlsGame) e.split('-')[0] : e.split('-')[1] };
    //print(map1);
  }

  /// DISPLAY
  Future<String> _getJsonDataDisplay( String endPoint, List valuesParams ) async {
    
    print(valuesParams);
    //valuesParams = ['N7305326','n7274034','w7275236','w7235370','N5632323','N5782890'];
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

    final jsonData = await _getJsonDataDisplay('listings', mlsNumbers); 

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
    //getSelectGame('1');
  }
}