import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';


class CardDetailsBox extends StatelessWidget {

  final Listing listing;

  const CardDetailsBox( this.listing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    
    final dataFormatted = DataFormatter(listing);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kSecondaryColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Text('Listed for: ', style: TextStyle(fontSize: 16, ), ),   
                    Text( 
                      dataFormatted.listPrice, 
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2E3191), ), 
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
          const Divider( height: 0,  thickness: 0.8, color: Color(0xFF0BB48B), ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded
              (
                child: Container(
                  height: 40.0,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color(0xFF0BB48B)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.king_bed_outlined, color: Color(0xFF0BB48B), size: 30,),
                      const SizedBox(width: 5,),
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
                      right: BorderSide(color: Color(0xFF0BB48B)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shower_outlined, color: Color(0xFF0BB48B), size: 30,),
                      const SizedBox(width: 5,),
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
                      right: BorderSide(color: Color(0xFF0BB48B)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.directions_car_filled_outlined, color: Color(0xFF0BB48B), size: 30,),
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
                    const SizedBox( width: 20.0,),
                      Text( 
                        dataFormatted.lotSqft, 
                        style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), 
                      ),
                    const SizedBox( width: 20.0,),  
                  ],
                )                   
              ),
            ],
          ),
          const Divider( height: 0,  thickness: 0.8, color: Color(0xFF0BB48B), ),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Listing #: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kSecondaryColor),),
                Text( 
                  listing.mlsNumber?? '', 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: kPrimaryColor),
                ),
              ],
            ),
          ),
          const Divider( height: 0,  thickness: 0.8, color: Color(0xFF0BB48B), ),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Direction/main: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kSecondaryColor),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( 
                      listing.address?.majorIntersection ?? '', 
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: kPrimaryColor),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}