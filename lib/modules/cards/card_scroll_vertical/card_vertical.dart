import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/modules/cards/card_scroll_vertical/card_stack_items.dart';
import 'package:flutter_black_white/modules/cards/card_scroll_vertical/card_vertical_box.dart';
import 'package:flutter_black_white/screens/map_property_screen.dart';

class CardVertical extends StatelessWidget {

  final Listing listing;

  const CardVertical( this.listing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(listing);

    const loggedIn = true;
    final String images = listing.images?.first?? '';
    const blurImg = loggedIn == false ? 5.0 : 0.0;
    final screenSize = MediaQuery.of(context).size;

    final String propertyType = listing.details?.propertyType?? '';

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        children: <Widget>[
          ImageFiltered(
            imageFilter: ImageFilter.blur( sigmaX: blurImg, sigmaY: blurImg),
            child: GestureDetector(
              onTap: () {
                if ( loggedIn == true ) {
                  Navigator.pushNamed(context, 'card_details_full_screen', arguments: listing);
                }
              }, 
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: <Widget>[
                        FadeInImage(
                          placeholder: const AssetImage('assets/no-image.jpg'), 
                          image: NetworkImage('$kRepliersCdn$images?w=1080'),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/no-image.jpg', fit: BoxFit.fitWidth);
                          },
                          width: double.infinity,
                          height: 227,
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration( milliseconds: 300), 
                        ),

                        Container(
                          width: 310,
                          height: 217, 
                          padding: const EdgeInsets.fromLTRB( 15, 0, 50, 0),
                          alignment: Alignment.bottomLeft,  
                          child: InkWell(
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: Icon(Icons.map_outlined, color: kSecondaryColor, size: 30),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, MapPropertyScreen.pathScreen, arguments: {'listing': listing});
                            },
                          ),                      
                        ),

                        Container(
                          width: double.infinity,
                          height: 217,
                          padding: const EdgeInsets.fromLTRB( 0, 0, 10, 0),
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            child: const Image(image: AssetImage('assets/play&learn_chip_53h.png'), ),
                            onTap: () {
                              //print('object');
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Text(' ${dataFormatted.listPrice}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryColor),),
                                    Container(
                                      padding: const EdgeInsets.symmetric( vertical: 2, horizontal: 5.0 ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: kPrimaryColor),
                                      ),
                                      child: Text(propertyType, style: const TextStyle(fontSize: 14, color: kPrimaryColor,),),
                                    ),                          
                                ],   
                              ),
                              const SizedBox(height: 2,),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined, color: kSecondaryColor, size: 22,),
                                  const SizedBox(width: 2,),
                                  ConstrainedBox(
                                    constraints: BoxConstraints( maxWidth: screenSize.width - 100 ),
                                    child: Text(dataFormatted.address, style: const TextStyle( fontSize: 16, color: Color(0xFF58595B)), overflow: TextOverflow.ellipsis,)
                                  ),                              
                                ],
                              ),
                              const SizedBox(height: 2,),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric( horizontal: 5.0),
                                  height: 25,
                                  child: FittedBox(
                                    child: Text(dataFormatted.addressCity, style: const TextStyle( color: Color(0xFF58595B)),),
                                  ),
                                ),
                              ),                             
                            ],
                          ),
                        ),
                        const SizedBox(height: 5,),
                        const Divider(  thickness: 0.8, color: kSecondaryColor, height: 0.0,),
                        CardVerticalBox(listing),                       
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),


          if ( loggedIn == true )
            CardStackItems(listing),

          if ( loggedIn == false )
            Container(
              width: 310,
              height: 430,
              //color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle( 
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF5f68be)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'details', arguments: listing);
                },
                child: const Text('Login required'),
              )
            ),          
        ]
      ),
    );
  }
}
