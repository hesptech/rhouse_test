import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/connectivity_internet.dart';
import 'package:flutter_black_white/utils/geolocation_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MapListProvider {

  MapListProvider();
  
  final String _baseUrl = 'api.repliers.io';
  final String _maptilerUrl = 'https://api.maptiler.com/maps/basic-v2/style.json?key={key}';  

  String get getMapTilerUrl {
    return _maptilerUrl;
  }

  String get getApiKey {
    return dotenv.get('API-KEY-MAPTILER');
  }


  Future<List<Listing>> getLocationsResidences() async {
    List<Listing> residences = [];
    try {
      if (!await ConnectivityInternet.hasConnection()) {
        return residences = [];
      }

      var latLng = await GeolocationApp().getPosition();
      // var response = await _getlistingsByRadius('listings', _pageListings, LatLng(latLng.latitude, latLng.longitude), 800);
      var response = await _getlistingsByRadius('listings', latLng, 500);


      residences = response.where((element) =>
          element.listingClass?.toLowerCase() == "residentialproperty" ||
          element.listingClass?.toLowerCase() == "condoproperty").toList();
      
      return residences;
    } catch (e) {
      return residences = [];
    }
  }

  Future<List<Listing>> _getlistingsByRadius(String endPoint, [LatLng? latLng, int radius = 0]) async {

    try {

      int pageListings = 1;
      String envApiKey = dotenv.get('REPLIERS-API-KEY');
      bool isMorePages = true; 
      List<Listing> responseResidences = [];


      while (isMorePages) {
        final url = Uri.https(_baseUrl, endPoint, {
          'pageNum': '$pageListings',
          'resultsPerPage': '500',
          'maxPrice': '2000000',
          'minPrice': '1500000',
          'type': 'sale',
          'hasImages': 'true',
          'lat': '${latLng?.latitude}',
          'long': '${latLng?.longitude}',
          'radius': '$radius'
        });


        Map<String, String>? headers = {'REPLIERS-API-KEY': envApiKey};

        if (!await ConnectivityInternet.hasConnection()) {
          isMorePages = false;
          break;
        }        

        final response = await http.get(url, headers: headers);


        if (response.statusCode != 200) {
          isMorePages = false;
          break;
        }

        final bodyResidences = ResponseBody.fromJson(response.body);

        if (pageListings < bodyResidences.numPages ) {
          pageListings++;
        } else {
          isMorePages = false;
        }

        responseResidences.addAll(bodyResidences.listings);
      }



      return responseResidences;
    } catch (e) {
      return [];
    }
  }
}
