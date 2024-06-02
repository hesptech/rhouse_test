import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class CardVerticalBox extends StatelessWidget {
  
  final Listing listing;

  const CardVerticalBox( this.listing, {super.key});

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(listing);
    
    return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              Container(
                width: 80.0,
                height: 35.0,
                decoration: const BoxDecoration(
                  // border: Border.all(color: const kSecondaryColor)
                  border: Border(
                    //top: BorderSide(color: kSecondaryColor),
                    //bottom: BorderSide(color: kSecondaryColor),
                    //left: BorderSide(color: kSecondaryColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 9,),
                    const Icon(Icons.king_bed_outlined, color: kSecondaryColor, size: 30,),
                    const SizedBox(width: 5,),
                    Text(
                      dataFormatted.numBedrooms, 
                      style: const TextStyle( 
                        color: Color(0xFF666597), 
                        fontWeight: FontWeight.bold, 
                        fontSize: 14, 
                      ), 
                    ),                                  
                  ],
                ),
              ),
              Container(
                width: 68.0,
                height: 35.0,
                //padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: kSecondaryColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 9,),
                    const Icon(Icons.shower_outlined, color: kSecondaryColor, size: 30,),
                    const SizedBox(width: 5,),
                    Text(
                      listing.details?.numBathrooms?? '', 
                      style: const TextStyle( color: Color(0xFF666597), 
                      fontWeight: FontWeight.bold, 
                      fontSize: 14, ), 
                    ),                                  
                  ],
                ),
              ),
              Container(
                width: 68.0,
                height: 35.0,
                //padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                  border: Border(
                    //top: BorderSide(color: kSecondaryColor),
                    //bottom: BorderSide(color: kSecondaryColor),
                    left: BorderSide(color: kSecondaryColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 9,),
                    const Icon(Icons.directions_car_filled_outlined, color: kSecondaryColor, size: 28,),
                    const SizedBox(width: 5,),
                    Text(
                      dataFormatted.numParkingSpaces, 
                      style: const TextStyle( 
                        color: Color(0xFF666597), 
                        fontWeight: FontWeight.bold, 
                        fontSize: 14, 
                      ), 
                    ),                                    
                  ],
                ),
              ),
              Container(
                width: 120.0,
                height: 35.0,
                //width: 104.0,
                //padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                  border: Border(
                    //top: BorderSide(color: kSecondaryColor),
                    //bottom: BorderSide(color: kSecondaryColor),
                    left: BorderSide(color: kSecondaryColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //const Icon(Icons.square_foot, color: kSecondaryColor, size: 24,),
                    //const SizedBox(width: 5,),
                    Text(
                      dataFormatted.lotSqft, 
                      style: const TextStyle( 
                        color: Color(0xFF666597), 
                        fontWeight: FontWeight.bold, 
                        fontSize: 14, 
                      ), 
                    ),                                    
                  ],
                ),
              ),                          
            ],                          
          );
  }
}