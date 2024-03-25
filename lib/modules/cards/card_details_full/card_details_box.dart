import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';


class CardDetailsBox extends StatelessWidget {

  final Listing listing;

  const CardDetailsBox( this.listing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    
    final dataFormatted = DataFormatter(listing);
    final bool statusActive = listing.status == 'A' ? true : false;
    String labelFormattedPriceStatus = statusActive ? 'Listed for' : 'SOLD FOR:';
    String labelFormattedPriceListed = 'Listed for:';

    return Container(
      margin: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: kSecondaryColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          labelFormattedPriceStatus, 
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: statusActive ? kPrimaryColor : kWarningColor,
                          ), 
                        )
                        ,
                        const SizedBox(width: 10.0,), 
                        Align(
                          //alignment: Alignment.center,
                          child: SizedBox(
                          
                            //alignment: Alignment.center,
                            height: 26,
                            child: FittedBox(
                              child: Text( 
                                statusActive ? dataFormatted.listPrice : dataFormatted.soldPrice, 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  color: statusActive ? kPrimaryColor : kWarningColor, 
                                ), 
                              ),
                            ),
                          ),
                        ),                   
                      ],
                    ),
                    if (!statusActive) Row(
                      children: [
                        Text(
                          labelFormattedPriceListed, 
                          style: TextStyle(
                            //fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: statusActive ? kPrimaryColor : kWarningColor,
                          ), 
                        )
                        ,
                        const SizedBox(width: 10.0,), 
                        Align(
                          //alignment: Alignment.center,
                          child: SizedBox(
                          
                            //alignment: Alignment.center,
                            height: 20,
                            child: FittedBox(
                              child: Text( 
                                dataFormatted.listPrice, 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  color: statusActive ? kPrimaryColor : kWarningColor, 
                                ), 
                              ),
                            ),
                          ),
                        ),                   
                      ],
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints( maxWidth: 100 ),
                  child: Text(
                    listing.details?.propertyType?? '',
                    style: const TextStyle(fontSize: 14, color: kPrimaryColor, fontWeight: FontWeight.bold ),
                    
                  ),
                ),                         
              ],                   
            ),
          ),
          const Divider( height: 0,  thickness: 0.8, color: kSecondaryColor, ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded
              (
                child: Container(
                  height: 40.0,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: kSecondaryColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.king_bed_outlined, color: kSecondaryColor, size: 30,),
                      const SizedBox(width: 3,),
                      Text( 
                        dataFormatted.numBedrooms, 
                        style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), 
                      ),  
                    ],
                  )                
                ),
              ),
              Expanded
              (
                child: Container(
                  height: 40.0,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: kSecondaryColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shower_outlined, color: kSecondaryColor, size: 30,),
                      const SizedBox(width: 3,),
                      Text( 
                        listing.details?.numBathrooms?? '', 
                        style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), 
                      ),  
                    ],
                  )                   
                ),
              ),
              Expanded
              (
                child: Container(
                  height: 40.0,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: kSecondaryColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.directions_car_filled_outlined, color: kSecondaryColor, size: 30,),
                      const SizedBox(width: 5,),
                      Text( 
                        dataFormatted.numParkingSpaces, 
                        style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), 
                      ),  
                    ],
                  )                   
                ),
              ),
              SizedBox(
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //const SizedBox( width: 15.0,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text( 
                        dataFormatted.lotSqft, 
                        style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), 
                      ),
                    ),
                    //const SizedBox( width: 15.0,),  
                  ],
                )                   
              ),
            ],
          ),
          const Divider( height: 0,  thickness: 0.8, color: kSecondaryColor, ),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('MLS #: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kSecondaryColor),),
                Text( 
                  listing.mlsNumber?? '', 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: kPrimaryColor),
                ),
              ],
            ),
          ),
          const Divider( height: 0,  thickness: 0.8, color: kSecondaryColor, ),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Main intersection: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kSecondaryColor),),
                  ],
                ),
                SizedBox(
                  height: 25,
                  child: FittedBox(
                    child: Text( 
                      listing.address?.majorIntersection ?? '', 
                      style: const TextStyle(fontWeight: FontWeight.w400, color: kPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if(dataFormatted.openHouse != '') const Divider( height: 0,  thickness: 0.8, color: kSecondaryColor, ),
          if(dataFormatted.openHouse != '') const SizedBox(height: 8.0,),
          /* if(dataFormatted.openHouse != '') Padding(
            padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('OPEN HOUSE: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kPrimaryColor),),
                Text( 
                  dataFormatted.openHouse, 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor),
                ),
              ],
            ),
          ), */


          if(dataFormatted.openHouse != '') _OpenHouse(openHouse: listing.openHouse,),
        ],
      ),
    );
  }
}

class _OpenHouse extends StatelessWidget {
  final Map<String, OpenHouse>? openHouse;

  const _OpenHouse({
    required this.openHouse,
  });

  @override
  Widget build(BuildContext context) {

    //return const Placeholder();
    return Column(
      children: [

        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: openHouse?.length,
          scrollDirection: Axis.vertical,
          itemBuilder: ( _, int index ) => Column(  
            children: [
              //Text(openHouse![(index+1).toString()]!.date),
              //Text((index+1).toString())
              OpenhouseDateFormatter(openHouse: openHouse![(index+1).toString()]!,)

            ],
          ),
        )


        /* Padding(
          padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('OPEN HOUSE: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kPrimaryColor),),
              Text( 
                dataFormatted.openHouse, 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor),
              ),
            ],
          ),
        ), */
      ],
    );
  }
}


class OpenhouseDateFormatter extends StatelessWidget {
  final OpenHouse openHouse;

  const OpenhouseDateFormatter({super.key, required this.openHouse,});

  @override
  Widget build(BuildContext context) {

    String openHouseDateDisplay = '';

    if(openHouse.date.isNotEmpty && openHouse.date != '') {
      DateTime parsedDate = DateTime.parse(openHouse.date);
      String dateFormat = DateFormat('dd-MM-yyyy').format(parsedDate); 

      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formatted = formatter.format(now);  

      List splittedStartTime = openHouse.startTime.split(':');
      List splittedEndTime = openHouse.endTime.split(':');
      String startTime = splittedStartTime[0];
      String endTime = splittedEndTime[0];

      List splittedAmPmFirst = openHouse.startTime.split(' ');
      List splittedAmPmSecond = openHouse.endTime.split(' ');
      String firstTime = splittedAmPmFirst[1];
      String secondTime = splittedAmPmSecond[1]; 

      if(formatted == dateFormat) {
        openHouseDateDisplay = 'TODAY $startTime$firstTime to $endTime$secondTime';
      } else if (parsedDate.isAfter(DateTime.now())){
        String dateWeekFormat = DateFormat('EEEE').format(parsedDate).substring(0, 3);
        openHouseDateDisplay = '$dateWeekFormat, $startTime$firstTime to $endTime$secondTime';
      } 
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (openHouseDateDisplay != '') const Text(
              'OPEN HOUSE: ', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kPrimaryColor),
            ),
          if (openHouseDateDisplay != '') Text(
            openHouseDateDisplay,
              style: const TextStyle(fontSize: 16, color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}