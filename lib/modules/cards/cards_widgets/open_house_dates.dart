import 'package:flutter/material.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class OpenHouseDates extends StatelessWidget {

  final Listing listing;
  final String cardType;

  const OpenHouseDates({super.key, required this.listing, required this.cardType});

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(listing);
    final bool statusActive = listing.status == 'A' ? true : false ;
    //final widthCardType = cardType == 'vertical' ? 65 : 105 ; 
    //final double buttonMaxSize = dataFormatted.openHouse != '' ? MediaQuery.of(context).size.width - widthCardType : 140.0 ;

    return Row(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: dataFormatted.openHouse != '' ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            alignment: Alignment.bottomLeft,
            backgroundColor: statusActive ? kPrimaryColor : kWarningColor,
            //minimumSize: Size(buttonMaxSize, 28.0),
            padding: const EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            //Navigator.pushNamed(context, 'details', arguments: movie);
          },
          child: Row(
            //mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(Icons.calendar_month_outlined, size: 16),
              const SizedBox(
                width: 5,
              ),
              Text(
                dataFormatted.listEntryDate,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, height: 1.0,),
              ),
              if(dataFormatted.openHouse != '') const Text(
                ' | OPEN: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, height: 1.0, color: Colors.yellow),
              ),
              if(dataFormatted.openHouse != '') Text(
                dataFormatted.openHouse,
                style: const TextStyle(fontSize: 13,  height: 1.0, color: Colors.yellow),
              ),
            ],
          ),
        ),              
      ],
    );
  }
}
