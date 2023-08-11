import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/utils/debouncer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RepliersSearch extends ChangeNotifier {
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500) 
  ); 

  final StreamController<List<Listing>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Listing>> get suggestionStream => _suggestionStreamController.stream;


  Future<List<Listing>> searchProperties( String query ) async {

    final url = Uri.https( kBaseUrl, 'listings', {
      //'pageNum': '$page',
      //'resultsPerPage': '15',
      'type': 'sale',
      'hasImages': 'true',
      //'fields': 'images,listPrice,address',
      'search': query,
      'class': ['condo','residential'],
      //'status': ['A','U'],
    });

    String envApiKey = dotenv.get('REPLIERS-API-KEY');

    Map<String, String>? headers = { 'REPLIERS-API-KEY': envApiKey };

    final response = await http.get(url, headers: headers); 

    try {
      if ( response.statusCode == 200 ) {
        final searchResponse = ResponseBody.fromJson(response.body);      
        return searchResponse.listings;
      } else {
        return [];
      }
    } catch (e) {
      //print('Error: $e');
      return [];
    }
  }

  void getSuggestionsByQuery(String searchTerm) {

    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchProperties(value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 200), ( _ ) { 
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 201)).then(( _ ) => timer.cancel());

  }  
}