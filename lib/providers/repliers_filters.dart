import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:http/http.dart' as http;


class RepliersFilters extends ChangeNotifier {

  String citySearchParam = '';
  List<Listing> onDisplayFilters = [];
  int numPages = 1;
  int onCount = 0;
  int _displayPageFilters = 0;
  bool isLoading = false;
  bool loaded = false;


  RepliersFilters( this.citySearchParam ) {
    citySearchParam == 'toronto' ? 'toronto' : citySearchParam ;
  }


  // get FILTERS
  Future<String> _getJsonDataFilters( String endPoint, Map<String, dynamic> valuesParams, [int page = 1] ) async {
    endPoint = 'listings';
    final url = Uri.https( kBaseUrl, endPoint, valuesParams);
    print( url );

    String envApiKey = dotenv.get('REPLIERS-API-KEY');

    Map<String, String>? headers = { 'REPLIERS-API-KEY': envApiKey };

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: headers);
    //return response.body;
    try {
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


  // filters params, loading, numPages, pageNum
  getDisplayFilters(Map<String, dynamic> filtersResults) async {

    if (isLoading) return;
    isLoading = true;

    _displayPageFilters++;
    filtersResults['pageNum'] = _displayPageFilters.toString(); 

    if(_displayPageFilters <= numPages ) {
      print('yess... $numPages $_displayPageFilters');

      final jsonData = await _getJsonDataFilters('listings', filtersResults, _displayPageFilters); 

      final nowPlayingResponse = ResponseBody.fromJson(jsonData);

      onDisplayFilters = [ ...onDisplayFilters, ...nowPlayingResponse.listings];
      onCount = nowPlayingResponse.count;
      numPages = nowPlayingResponse.numPages;
      print(onCount);
      loaded = true;
      notifyListeners();
      isLoading = false;
    } else {
      print('nooo... $numPages $_displayPageFilters');
      isLoading = false;
    }
    
  }

  initGetDisplay(Map<String, dynamic> filtersResults) {
    _displayPageFilters = 0;
    onDisplayFilters = [];
    onCount = 0;
    loaded = false;
    getDisplayFilters(filtersResults);
  }
}
