import 'package:flutter_black_white/models/models.dart';


class DataFormatter {

  final Listing listing; 

  const DataFormatter( this.listing );


  String listingListPrice() {
    String listPrice = listing.listPrice?? '' ;
    double doubleString = double.parse(listPrice);
    String formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    return formattedPrice;
  }

  String get listPrice {
    return listingListPrice();
  }


  String listingNumBedrooms() {
    final String numBedrooms = listing.details?.numBedrooms?? '';
    final String numBedroomsPlus = listing.details?.numBedroomsPlus == '' ? '' : '+${listing.details?.numBedroomsPlus}';
    final String totalBedrooms = '$numBedrooms$numBedroomsPlus';
    return totalBedrooms;
  }

  String get numBedrooms {
    return listingNumBedrooms();
  }


  String listingNumParkingSpaces() {
    final String numParkingSpacesString = listing.details?.numParkingSpaces?? '';
    final List arrayParkingSpaces = numParkingSpacesString.split('.');
    final String newParkingSpaces = arrayParkingSpaces[0];
    return newParkingSpaces;
  }

  String get numParkingSpaces {
    return listingNumParkingSpaces();
  }


  String listingLotSqft() {
    final String depth = listing.lot?.depth?? '';
    final List newDepth = depth.split('.');
    final String noZerosDepth = newDepth[0];

    final String width = listing.lot?.width?? ''; 
    final List newWidth = width.split('.');
    final String noZerosWidth = newWidth[0];

    final String sqft = listing.details?.sqft?? '';
    final listingClass = listing.listingClass?? '';
    final String sizeLot = listingClass == 'ResidentialProperty' ? '$noZerosDepth x $noZerosWidth ft.' : '$sqft sqft' ;
    return sizeLot;
  }

  String get lotSqft {
    return listingLotSqft();
  }


  bool emptyDataCheck( String value ) {
    if (value == '') {
      return false;
    } 
    return true;
  }


}
