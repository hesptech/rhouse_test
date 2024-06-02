import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_black_white/models/models.dart';


class RepliersListingMls extends ChangeNotifier {

  List<History> onDisplayHistory = [];
  //ResponseListing onDisplayData = ResponseListing();

  Future<String> _getJsonData( dynamic endPoint ) async {

    final url = Uri.https( kBaseUrl, endPoint, {
      'fields': 'history',
    });
    //print( url );

    Map<String, String>? headers = { 'REPLIERS-API-KEY': dotenv.get('REPLIERS-API-KEY') };

    try {
      final response = await http.get(url, headers: headers);
      if ( response.statusCode == 200 ) {
        return response.body;
      } else {
        return processResponse(response);
      }
    } catch (e) {
      //print('Error: $e');
      return 'Error: $e';
    }
  }


  getListingHistory( dynamic pathParam ) async {
 
    String endPoint = 'listings/$pathParam';
    final jsonData = await _getJsonData( endPoint ); 

    final mlsListingResponse = ResponseListing.fromJson(jsonData);

    onDisplayHistory = mlsListingResponse.history?? [];
    notifyListeners();
  }

  initGetDisplay() {
    onDisplayHistory = [];
  }


  /* getListingMlsData( dynamic pathParam ) async {
 
    String endPoint = 'listings/$pathParam';
    final jsonData = await _getJsonData( endPoint );


    final mlsListingResponse = ResponseListing.fromJson(jsonData);


    onDisplayData = mlsListingResponse;
    notifyListeners();
  }


  initListingMlsData() {
    onDisplayData = ResponseListing();
  } */
  
}
