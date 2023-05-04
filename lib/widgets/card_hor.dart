
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class CardHor extends StatelessWidget {

  final Listing listing;
  final bool loggedIn = true;

  const CardHor(this.listing, {Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(listing);

    const loggedIn = true;
    const blurImg = loggedIn == false ? 5.0 : 0.0 ; 
    final screenSize = MediaQuery.of(context).size;

    // Gen. Info
    final String images = listing.images?.first?? '';
    final String propertyType = listing.details?.propertyType?? '';
    final String numBathrooms = listing.details?.numBathrooms?? '';

    String neighborhood = listing.address?.neighborhood?? '';
    final String city = listing.address?.city?? '';
    final String cityArea = listing.address?.area == 'Toronto' ? 'Toronto' : city ;

     
    if ( neighborhood == 'Waterfront Communities C1' ) {
      neighborhood == 'Waterfront Communities West';
    } else if ( neighborhood == 'Waterfront Communities C8' ) {
      neighborhood == 'Waterfront Communities East';
    } 

    final String finalAddress2 = '$neighborhood, $cityArea';
    String finalAddress3 = '';
    if ( finalAddress2.length > 30 ) {
      finalAddress3 = '${finalAddress2.substring(0, 30)}...';
    } else {
      finalAddress3 = finalAddress2;
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [

            ImageFiltered(
              imageFilter: ImageFilter.blur( sigmaX: blurImg, sigmaY: blurImg ),
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
                    // IMAGE box
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: <Widget>[
                          FadeInImage(
                            placeholder: const AssetImage('assets/no-image.jpg'), 
                            //image: AssetImage('assets/house_340x227.jpg'),
                            image: NetworkImage('https://cdn.repliers.io/$images?w=500'),
                            width: 310,
                            height: 207,
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration( milliseconds: 300),
                          ),
                          Container(
                            width: 310,
                            height: 207, 
                            padding: const EdgeInsets.fromLTRB( 0, 15, 10, 0),
                            alignment: Alignment.topRight,  
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 1.0,
                                  top: 2.0,
                                  child: Icon(Icons.filter_9_plus_outlined, color: Colors.black26, size: 30),
                                ),
                                InkWell(
                                  child: const Icon(Icons.filter_9_plus_outlined, color: Color(0xFFffffff), size: 30),
                                  onTap: () {
                                    //Navigator.pushNamed(context, 'card_images_screen', arguments: mlsNumber);
                                    Navigator.pushNamed(context, 'card_images_screen', arguments: listing);
                                    //print('object');
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 310,
                            height: 207, 
                            padding: const EdgeInsets.fromLTRB( 0, 15, 50, 0),
                            alignment: Alignment.topRight,  
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 1.0,
                                  top: 2.0,
                                  child: Icon(Icons.favorite_border_outlined, color: Colors.black26, size: 30),
                                ),
                                InkWell(
                                  child: const Icon(Icons.favorite_border_outlined, color: Color(0xFFffffff), size: 30),
                                  onTap: () {
                                    //print('object');
                                  },
                                )
                              ],
                            ),                        
                          ),
                          Container(
                            width: 310,
                            height: 207,
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              child: const Image(image: AssetImage('assets/play&learn_chip_53h.png'), ),
                              onTap: () {
                                //print('object');
                              },
                            ),
                          )
                        ], 
                      ),
                    ),
                    
                    SizedBox(
                      height: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 328.0,
                            padding: const EdgeInsets.only(left: 10.0, top: 0, right: 10.0, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' ${dataFormatted.listPrice}', 
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2E3191)),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric( vertical: 2, horizontal: 5.0 ),
                                  decoration: BoxDecoration(
                                     border: Border.all(color: const Color(0xFF2E3191)),
                                  ),
                                  child: Text(propertyType, style: const TextStyle(fontSize: 14, color: Color(0xFF2E3191),),),
                                ),                          
                              ],   
                            ),
                          ),
                          Container(
                            width: 328.0,
                            padding: const EdgeInsets.only(left: 10.0, top: 5, right: 10.0, bottom: 0),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on_outlined, color: Color(0xFF0BB48B), size: 22,),
                                const SizedBox(width: 2,),
                                ConstrainedBox(
                                  constraints: BoxConstraints( maxWidth: screenSize.width - 130 ),
                                  child: Text(dataFormatted.address, style:const TextStyle( fontSize: 16, color: Color(0xFF58595B)), overflow: TextOverflow.ellipsis,)
                                ),                            
                              ],
                            ),
                          ), 
                          Container(
                            width: 328.0,
                            padding: const EdgeInsets.only(left: 10.0, top: 3, right: 10.0, bottom: 10),
                            child: Row(
                              children: [
                                const SizedBox( width: 25.0 ),
                                Text(finalAddress3, style: const TextStyle( fontSize: 16, color: Color(0xFF58595B), ), ),                          
                              ],
                            ),
                          ), 
                          Row(
                            children: [
                              Container(
                                width: 80.0,
                                height: 35.0,
                                decoration: const BoxDecoration(
                                  // border: Border.all(color: const Color(0xFF0BB48B))
                                  border: Border(
                                    top: BorderSide(color: Color(0xFF0BB48B)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.king_bed_outlined, color: Color(0xFF0BB48B), size: 30,),
                                    const SizedBox(width: 5,),
                                    Text(
                                      dataFormatted.numBedrooms , 
                                      style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), 
                                    ),                                  
                                  ],
                                ),
                              ),
                              Container(
                                width: 68.0,
                                height: 35.0,
                                padding: const EdgeInsets.all(3.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Color(0xFF0BB48B)),
                                    left: BorderSide(color: Color(0xFF0BB48B)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.shower_outlined, color: Color(0xFF0BB48B), size: 30,),
                                    const SizedBox(width: 5,),
                                    Text(numBathrooms, style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), ),                                  
                                  ],
                                ),
                              ),
                              Container(
                                width: 68.0,
                                height: 35.0,
                                padding: const EdgeInsets.all(3.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Color(0xFF0BB48B)),
                                    left: BorderSide(color: Color(0xFF0BB48B)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                height: 35.0,
                                width: 112.0,
                                padding: const EdgeInsets.all(0.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Color(0xFF0BB48B)),
                                    left: BorderSide(color: Color(0xFF0BB48B)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //const SizedBox(width: 5,),
                                    Text(dataFormatted.lotSqft, style: const TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), textAlign: TextAlign.center,)                                    
                                  ],
                                ),
                              ),
                            ],                          
                          ),                        
                        ],
                      ),
                    ),

                    //Text('\n ${listing.listingClass}')
            
                  ],
                ),              
              ),
            ),


            if ( loggedIn == true )
            Container(
              padding: const EdgeInsets.only(left: 20.0, top: 10.0,),
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E3191),
                  minimumSize: const Size(140.0, 28.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, 'details', arguments: listing);
                },
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined, size: 16,),
                    const SizedBox(width: 5,),
                    Text(dataFormatted.listEntryDate, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400))
                  ],
                ),
              )
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
                  //Navigator.pushNamed(context, 'details', arguments: listing);
                },
                child: const Text('Login required'),
              )
            ),
          ],
        )
      )
    );
  }
}