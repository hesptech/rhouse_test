import 'package:flutter/material.dart';

import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/models/models.dart';

class CardSearch extends StatelessWidget {

  final Listing propertyItem;

  const CardSearch(this.propertyItem, {super.key});

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(propertyItem);
    final String images = propertyItem.images?.first?? '';

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric( horizontal: 10.0, vertical: 7.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'card_details_full_screen', arguments: propertyItem);
        }, 
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage(
              placeholder: const AssetImage('assets/no-image_128_85.jpg'), 
              image: NetworkImage('$kRepliersCdn$images?w=250'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/no-image_128_85.jpg', fit: BoxFit.fitWidth);
              },
              width: 115,
              height: 85,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dataFormatted.listPrice, 
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric( vertical: 2, horizontal: 5.0 ),
                          decoration: BoxDecoration(
                              border: Border.all(color: kPrimaryColor),
                          ),
                          child: Text(
                            propertyItem.details?.propertyType?? '', 
                            style: const TextStyle(fontSize: 12, color: kPrimaryColor,),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0,),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text( dataFormatted.address,)
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text( dataFormatted.addressCity, ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 20.0,
                            /* decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(color: kSecondaryColor),
                              ),
                            ), */
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
                            /* decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(color: kSecondaryColor),
                              ),
                            ), */
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
                            /* decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(color: kSecondaryColor),
                              ),
                            ), */
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

                        /* SizedBox(
                          height: 18.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //const SizedBox( width: 20.0,),
                              Container(
                                //padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text( 
                                  dataFormatted.lotSqft, 
                                  style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 12, ), 
                                ),
                              ),
                              //const SizedBox( width: 20.0,), 
                            ],
                          )                   
                        ), */

                      ],
                    )
                  ],
                ),
              )
            )          
          ],    
        ),
      ),
    );
  }
}