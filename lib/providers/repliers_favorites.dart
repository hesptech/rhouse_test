import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RepliersFavorites extends ChangeNotifier {
  List<Listing> onDisplayFavorites = [];
  bool isLoading = false;
  bool loaded = false;
  int onCount = 0;

  Future<String> _getJsonData( String endPoint, List valuesParams ) async {
    
    //print(valuesParams);
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

  getDisplayFavorites(List mlsNumbers) async {

    if (isLoading) return;
    isLoading = true;

    final jsonData = await _getJsonData('listings', mlsNumbers); 

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
  }
}