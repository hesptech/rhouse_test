import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/widgets/widgets.dart';

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
    final String numBathrooms = listing.details?.numBathrooms?? '';

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
                } else {
                  //Navigator.restorablePopAndPushNamed(context, '/');
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
                          image: NetworkImage('$kRepliersCdn$images?w=500'),
                          width: double.infinity,
                          height: 227,
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration( milliseconds: 300), 
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
                                  const Icon(Icons.location_on_outlined, color: Color(0xFF0BB48B), size: 22,),
                                  const SizedBox(width: 2,),
                                  ConstrainedBox(
                                    constraints: BoxConstraints( maxWidth: screenSize.width - 100 ),
                                    child: Text(dataFormatted.address, style: const TextStyle( fontSize: 16, color: Color(0xFF58595B)), overflow: TextOverflow.ellipsis,)
                                  ),                              
                                ],
                              ),
                              const SizedBox(height: 2,),
                              /* Row(
                                children: <Widget>[
                                  /* const Icon(Icons.location_on_outlined, color: Color(0xFF0BB48B), size: 26,),
                                  const SizedBox(width: 2,),
                                  ConstrainedBox(
                                    constraints: BoxConstraints( maxWidth: screenSize.width - 140),
                                    child: const Text('18 Wanstead Ave. Scarborough Oakridge', style: TextStyle( fontSize: 18, color: Color(0xFF58595B)), overflow: TextOverflow.ellipsis,)
                                  ), */  
                                  const SizedBox( width: 25.0 ),
                                  Text(dataFormatted.addressCity, style: const TextStyle( fontSize: 16, color: Color(0xFF58595B)), ),                          
                                ],
                              ), */
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
                        const Divider(  thickness: 0.8, color: Color(0xFF0BB48B), height: 0.0,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [ 
                            Container(
                              width: 80.0,
                              height: 35.0,
                              decoration: const BoxDecoration(
                                // border: Border.all(color: const Color(0xFF0BB48B))
                                border: Border(
                                  //top: BorderSide(color: Color(0xFF0BB48B)),
                                  //bottom: BorderSide(color: Color(0xFF0BB48B)),
                                  //left: BorderSide(color: Color(0xFF0BB48B)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 9,),
                                  const Icon(Icons.king_bed_outlined, color: Color(0xFF0BB48B), size: 30,),
                                  const SizedBox(width: 5,),
                                  Text(
                                    dataFormatted.numBedrooms, 
                                    style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), 
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
                                  left: BorderSide(color: Color(0xFF0BB48B)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 9,),
                                  const Icon(Icons.shower_outlined, color: Color(0xFF0BB48B), size: 30,),
                                  const SizedBox(width: 5,),
                                  Text(numBathrooms, style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), ),                                  
                                ],
                              ),
                            ),
                            Container(
                              width: 68.0,
                              height: 35.0,
                              //padding: const EdgeInsets.all(3.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  //top: BorderSide(color: Color(0xFF0BB48B)),
                                  //bottom: BorderSide(color: Color(0xFF0BB48B)),
                                  left: BorderSide(color: Color(0xFF0BB48B)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 9,),
                                  const Icon(Icons.directions_car_filled_outlined, color: Color(0xFF0BB48B), size: 28,),
                                  const SizedBox(width: 5,),
                                  Text(
                                    dataFormatted.numParkingSpaces, 
                                    style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), 
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
                                  //top: BorderSide(color: Color(0xFF0BB48B)),
                                  //bottom: BorderSide(color: Color(0xFF0BB48B)),
                                  left: BorderSide(color: Color(0xFF0BB48B)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //const Icon(Icons.square_foot, color: Color(0xFF0BB48B), size: 24,),
                                  //const SizedBox(width: 5,),
                                  Text(dataFormatted.lotSqft, style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), )                                    
                                ],
                              ),
                            ),                          
                          ],                          
                        ),                        
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),


          if ( loggedIn == true )
          CardStackItems(listing),
            if ( loggedIn == true )
            Container(
              width: double.infinity,
              height: 207,
              padding: const EdgeInsets.fromLTRB( 0, 0, 20, 0),
              alignment: Alignment.bottomRight,
              child: InkWell(
                child: const Image(image: AssetImage('assets/play&learn_chip_53h.png'), ),
                onTap: () {
                  //print('object');
                },
              ),
            ),
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
