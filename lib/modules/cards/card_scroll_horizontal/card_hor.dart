//import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
//import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/utils/card_full_description_arguments.dart';
import 'package:flutter_black_white/modules/cards/card_scroll_horizontal/card_horizontal_box.dart';
import 'package:flutter_black_white/modules/cards/card_scroll_horizontal/card_horizontal_stack.dart';
import 'package:flutter_black_white/modules/cards/card_scroll_horizontal/card_hor_stack_bottom.dart';
//import 'package:flutter_black_white/screens/map_property_screen.dart';

class CardHor extends StatelessWidget {

  final Listing listing;
  final bool loggedIn = true;

  const CardHor(this.listing, {Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(listing);
    const loggedIn = true;
    //const blurImg = loggedIn == false ? 5.0 : 0.0 ; 
    //final screenSize = MediaQuery.of(context).size;
    final String images = listing.images?.first?? '';
    String propertyType = listing.details?.propertyType?? '';
    propertyType = propertyType.length > 16 ? '${propertyType.substring(0,12)}...' : propertyType ;
    final bool statusActive = listing.status == 'A' ? true : false ;

    return SizedBox(
      width: 350.0,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Stack(
          children: [
    
            GestureDetector(
              onTap: () {
                if ( loggedIn == true ) {
                  Navigator.pushNamed(
                    context, 
                    'card_details_full_screen', 
                    arguments: CardFullDescriptionArguments(listing, '/'),
                  );
                } else {
                  //Navigator.restorablePopAndPushNamed(context, '/');
                }
              }, 
              child: Column(
                children: [
                  // IMAGE box
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10.0, bottom: 5),
                    child: Stack(
                      children: <Widget>[
                        FadeInImage(
                          placeholder: const AssetImage('assets/no_images_subs/no-image_3.jpg'), 
                          image: NetworkImage('$kRepliersCdn$images?class=medium'),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/no_images_subs/no-image_3.jpg', 
                              fit: BoxFit.fitWidth,
                            );
                          },
                          width: 310,
                          height: 207,
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration( milliseconds: 300),
                        ),
                      ], 
                    ),
                  ),
                  
                  SizedBox(
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 328.0,
                          padding: const EdgeInsets.only(left: 10.0, top: 0, right: 10.0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        statusActive ? 'LISTED\nFOR' : 'SOLD FOR',
                                        style: TextStyle(
                                          fontSize: 13, 
                                          fontWeight: FontWeight.bold, 
                                          color: statusActive ? kPrimaryColor : kWarningColor,
                                        ),
                                      ),
                                      const SizedBox(width: 5.0,),
                                      Text(
                                        statusActive ? ' ${dataFormatted.listPrice}' : dataFormatted.soldPrice,
                                        style: TextStyle(
                                          fontSize: 20, 
                                          fontWeight: FontWeight.bold, 
                                          color: statusActive ? kPrimaryColor : kWarningColor,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                  if(!statusActive) Row(
                                    children: [
                                      Text(
                                        'LISTED FOR',
                                        style: TextStyle(
                                          fontSize: 12, 
                                          fontWeight: FontWeight.bold, 
                                          color: statusActive ? kPrimaryColor : kWarningColor,
                                        ),
                                      ),
                                      const SizedBox(width: 5.0,),
                                      Text(
                                        dataFormatted.listPrice,
                                        style: TextStyle(
                                          fontSize: 14, 
                                          fontWeight: FontWeight.bold, 
                                          color: statusActive ? kPrimaryColor : kWarningColor,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric( vertical: 2, horizontal: 5.0 ),
                                decoration: BoxDecoration(
                                   border: Border.all(color: kPrimaryColor),
                                ),
                                child: Text(propertyType, style: const TextStyle(fontSize: 14, color: kPrimaryColor,),),
                              ),                          
                            ],   
                          ),
                        ),
                        Container(
                          width: 328.0,
                          padding: const EdgeInsets.only(left: 10.0, top: 5, right: 10.0, bottom: 0),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined, color: kSecondaryColor, size: 22,),
                              const SizedBox(width: 2,),
                              /* ConstrainedBox(
                                constraints: BoxConstraints( maxWidth: screenSize.width - 130 ),
                                child: Text(dataFormatted.address, style:const TextStyle( fontSize: 16, color: Color(0xFF58595B)), overflow: TextOverflow.ellipsis,)
                              ), */   
    
                              SizedBox(
                                height: 22,
                                child: FittedBox(
                                  child: Text(
                                    dataFormatted.address, 
                                    style: const TextStyle( 
                                      color: Color(0xFF58595B),
                                    ), 
                                      //overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ),
    
                            ],
                          ),
                        ), 
     
    
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 328.0,
                            padding: const EdgeInsets.only(left: 15.0, right: 5.0,),
                            height: 22,
                            child: FittedBox(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                dataFormatted.addressCity, 
                                style: const TextStyle( 
                                  color: Color(0xFF58595B),
                                ),
                              ),
                            ),
                          ),
                        ), 
                        statusActive ? const SizedBox(height: 10,) : const SizedBox(height: 5,),
    
                        CardHorizontalBox(listing),                        
                      ],
                    ),
                  ),
                ],
              ),              
            ),
            CardHorizontalStack(listing),
            CardHorStackBottom(listing),
          ],
        )
      ),
    );
  }
}