import 'package:flutter_black_white/models/models.dart';
import 'package:intl/intl.dart';

class DataFormatter {

  final Listing listing; 

  const DataFormatter( this.listing );


  String listingEntryDate() {
    DateTime listingEntryDate = listing.timestamps?.listingEntryDate?? DateTime.now();
    DateTime addDt = DateTime.now();
    Duration diffDt = addDt.difference(listingEntryDate); 
    final formattedEntryDate = diffDt.inDays == 0 ? 'Listed today' : diffDt.inDays == 1 ? 'Listed ${diffDt.inDays} day ago' : 'Listed ${diffDt.inDays} days ago';
    return formattedEntryDate;
  }

  String get listEntryDate {
    return listingEntryDate();
  }

  String listingEntryDateSold() {
    DateTime listingSoldDate = listing.soldDate?? DateTime.now();
    DateTime addDt = DateTime.now();
    Duration diffDt = addDt.difference(listingSoldDate);
    final formattedSoldDate = diffDt.inDays == 0 ? 'SOLD today' : diffDt.inDays == 1 ? 'SOLD ${diffDt.inDays} day ago' : 'SOLD ${diffDt.inDays} days ago';
    return formattedSoldDate;
  }


  String get listEntryDateSold {
    return listingEntryDateSold();
  }


  String listingListPrice() {
    String listPrice = listing.listPrice?? '0.00' ;
    double doubleString = double.parse(listPrice);
    String formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    return formattedPrice;
  }

  String get listPrice {
    return listingListPrice();
  }

  String listingSoldPrice() {
    String soldPrice = listing.soldPrice?? '0.00' ;
    double doubleString = double.parse(soldPrice);
    String formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    return formattedPrice;
  }


  String get soldPrice {
    return listingSoldPrice();
  }


  String listingAddress() {
    final String unitNumber = listing.address?.unitNumber?? '';
    final String unitNumberHyphen = unitNumber == '' ? '' : '$unitNumber - ' ;
    final String streetNumber = listing.address?.streetNumber?? ''; 
    final String streetName = listing.address?.streetName?? '';
    final String streetSuffix = listing.address?.streetSuffix?? '';
    final String streetDirection = listing.address?.streetDirection?? '';
    final String formattedAddress = '$unitNumberHyphen$streetNumber $streetName $streetSuffix $streetDirection';
    return formattedAddress;
  }

  String get address {
    return listingAddress();
  }


  String listingAddressCity() {
    final String neighborhood = listing.address?.neighborhood?? '';
    final String city = listing.address?.city?? '';
    final String cityArea = listing.address?.area == 'Toronto' ? 'Toronto' : city ;

    if ( neighborhood == 'Waterfront Communities C1' ) {
      neighborhood == 'Waterfront Communities West';
    } else if ( neighborhood == 'Waterfront Communities C8' ) {
      neighborhood == 'Waterfront Communities East';
    }

    final String finalAddress2 = '$neighborhood, $cityArea';
    String finalAddress3 = '';
    if ( finalAddress2.length > 40 ) {
      finalAddress3 = '${finalAddress2.substring(0, 35)}...';
    } else {
      finalAddress3 = finalAddress2;
    }
    return finalAddress3;
  }

  String get addressCity {
    return listingAddressCity();
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
    final String sizeLot = listingClass == 'ResidentialProperty' ? '$noZerosDepth x $noZerosWidth ft' : '$sqft sqft' ;
    return sizeLot;
  }

  String get lotSqft {
    return listingLotSqft();
  }


  // Openhouse
  String listingOpenHouse() {
    final Map<String, OpenHouse>? openHouseData = listing.openHouse;
    String openHouseDateDisplay = '';

    for (var value in openHouseData!.values) {
      if(value.date.isNotEmpty && value.date != '') {
      //print('value date:  ${value.date}');
        //var parsedDate = DateTime.parse(value.date!.substring(0, 10));
        DateTime parsedDate = DateTime.parse(value.date);
        String dateFormat = DateFormat('dd-MM-yyyy').format(parsedDate);

        DateTime now = DateTime.now();
        DateFormat formatter = DateFormat('dd-MM-yyyy');
        String formatted = formatter.format(now);
        
        //print('$formatted $dateFormat');

        if(formatted == dateFormat) {
          //print('after: ${value.date!.substring(0, 10)}');
          //openHouseDateDisplay = 'after ${dateFormat}';
          openHouseDateDisplay = 'TODAY ${value.startTime} ${value.endTime}';
          break;
        } else if (parsedDate.isAfter(DateTime.now())){
          //print('after: ${value.date!.substring(0, 10)}');
          //openHouseDateDisplay = 'after ${dateFormat}';
          String dateWeekFormat = DateFormat('EEEE').format(parsedDate).substring(0, 3);
          //String dateDD = DateFormat('dd').format(parsedDate);

          List splittedStartTime = value.startTime.split(':');
          List splittedEndTime = value.endTime.split(':');
          String startTime = splittedStartTime[0];
          String endTime = splittedEndTime[0];

          List splittedAmPmFirst = value.startTime.split(' ');
          List splittedAmPmSecond = value.endTime.split(' ');
          String firstTime = splittedAmPmFirst[1];
          String secondTime = splittedAmPmSecond[1];


          //openHouseDateDisplay = dateFormat;
          //openHouseDateDisplay = ' $dateWeekFormat. $dateDD, ${value.startTime} ${value.endTime}';
          openHouseDateDisplay = '$dateWeekFormat, $startTime$firstTime $endTime$secondTime';
          break;
        } else if (parsedDate.isBefore(DateTime.now()) || dateFormat != ''){
          //print('before: ${parsedDate}');
          //openHouseDateDisplay = 'before ${parsedDate}';
          //break;
        }
      } else {
        //openHouseDateDisplay = '';
      }      
    }

    return openHouseDateDisplay;
  }

  String get openHouse {
    return listingOpenHouse();
  } 


  bool emptyDataCheck( String value ) {
    if (value == '') {
      return false;
    } 
    return true;
  }


}
