import 'package:flutter/material.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/models/models.dart';

class CardFavoritesIcons extends StatelessWidget {
  final Listing propertyItem;
  
  const CardFavoritesIcons(this.propertyItem, {super.key, });

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(propertyItem);

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.king_bed_outlined, color: kSecondaryColor, size: 20,),
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
          child: SizedBox(
            height: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shower_outlined, color: kSecondaryColor, size: 20,),
                const SizedBox(width: 3,),
                Text( 
                  propertyItem.details?.numBathrooms?? '', 
                  style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), 
                ),  
              ],
            )                   
          ),
        ),

        Expanded
        (
          child: SizedBox(
            height: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.directions_car_filled_outlined, color: kSecondaryColor, size: 20,),
                const SizedBox(width: 5,),
                Text( 
                  dataFormatted.numParkingSpaces, 
                  style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), 
                ),  
              ],
            )                   
          ),
        ),
      ],
    );
  }
}