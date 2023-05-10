import 'package:flutter_black_white/models/response_listings.dart';
import 'package:latlong2/latlong.dart';

class FilterListingsModel {
  List<Listing> listings;
  List<CoordinatesListings> coordinatesListings;

  FilterListingsModel({this.coordinatesListings = const [], this.listings = const []});
}

class CoordinatesListings {
  String mlsNumber;
  LatLng? coordinates;

  CoordinatesListings({this.coordinates, this.mlsNumber = ""});
}