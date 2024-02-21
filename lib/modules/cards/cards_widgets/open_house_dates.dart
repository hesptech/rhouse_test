import 'package:intl/intl.dart';
import 'package:flutter_black_white/models/models.dart';

class OpenHouseDates {

  final Listing listing;

  const OpenHouseDates({required this.listing});

  String openHouseInfo() {


    final Map<String, OpenHouse>? openHouseData = listing.openHouse;
    //final openHouseDate = OpenHouseDates(listing: widget.listing);

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
          openHouseDateDisplay = 'TODAY';
          break;
        } else if (parsedDate.isAfter(DateTime.now())){
          //print('after: ${value.date!.substring(0, 10)}');
          //openHouseDateDisplay = 'after ${dateFormat}';
          String dateWeekFormat = DateFormat('EEEE').format(parsedDate);
          String dateDD = DateFormat('dd').format(parsedDate);
          //openHouseDateDisplay = dateFormat;
          openHouseDateDisplay = '$dateWeekFormat $dateDD';
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
}
