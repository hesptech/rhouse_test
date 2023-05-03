import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/cards/card_details_box.dart';



class CardDetailsTop extends StatelessWidget {

  final Listing listing;

  const CardDetailsTop( this.listing, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size; 
    final String images = listing.images?.first?? '';

    // days on market
    DateTime listingEntryDate = listing.timestamps?.listingEntryDate?? DateTime.now();
    DateTime addDt = DateTime.now();
    Duration diffDt = addDt.difference(listingEntryDate); 
    final finalDiffDt = diffDt.inDays == 0 ? 'Listed today' : 'Listed ${diffDt.inDays} day(s) ago';

    // Address
    final String unitNumber = listing.address?.unitNumber?? '';
    final String unitNumberHyphen = unitNumber == '' ? '' : '$unitNumber - ' ;
    final String streetNumber = listing.address?.streetNumber?? ''; 
    final String streetName = listing.address?.streetName?? '';
    final String streetSuffix = listing.address?.streetSuffix?? '';
    final String streetDirection = listing.address?.streetDirection?? '';
    final String streetLine = '$unitNumberHyphen$streetNumber $streetName $streetSuffix $streetDirection';
    String neighborhood = listing.address?.neighborhood?? '';
    final String city = listing.address?.city?? '';
    //final String area = listing.address?.area?? '';
    final String cityArea = listing.address?.area == 'Toronto' ? 'Toronto' : city ;
    final String finalAddress2 = '$neighborhood, $cityArea';
    String finalAddress3 = '';
    if ( finalAddress2.length > 25 ) {
      finalAddress3 = '${finalAddress2.substring(0, 25)}...';
    } else {
      finalAddress3 = finalAddress2;
    }

    return Container(
            margin: const EdgeInsets.all(14),
            child: Stack(
              children: [
                Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      child: FadeInImage(
                        height: 300,
                        placeholder: const AssetImage('assets/no-image.jpg'), 
                        //image: AssetImage('assets/house_500x300.jpg'),
                        image: NetworkImage('https://cdn.repliers.io/$images?w=500'),
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration( milliseconds: 300),
                      ),
                      //child: const Placeholder( fallbackHeight: 300.0, ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                      child: Column(
                        children: [   
                          Row(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints( maxWidth: screenSize.width - 110 ),
                                child: Text(streetLine, textAlign: TextAlign.left ,maxLines: 3, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryColor, overflow: TextOverflow.ellipsis, ),),
                              ),
                            ],
                          ),
                          //const SizedBox( height: 5.0 ,),
                          Row(
                            children: [
                              Text(finalAddress3, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: kPrimaryColor),),
                              const SizedBox( width: 10.0, ),
                              //Icon(Icons.map_outlined, color: Color(0xFF0BB48B), size: 32,),
                            ],
                            
                          ),
                          //const Divider( height: 28,  thickness: 0.8, color: Color(0xFF0BB48B), ),
                          const SizedBox( height: 28,),
                          CardDetailsBox( listing ),
                          const SizedBox( height: 28,),
                          /* Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('PROPERTY LISTING HISTORY', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kSecondaryColor),),
                            ],
                          ),
                          const SizedBox( height: 10.0, ),
                          Row(
                            children: const [
                              Text('2022-02-22 ', style: TextStyle(fontSize: 20, ), ),
                              Text('\$1,825,000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                              SizedBox( width: 10.0, ),
                              Text('SOLD', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kPrimaryColor),),
                            ],
                          ),
                          const Divider( height: 14.0,  thickness: 0.8, color: kPrimaryColor, ),
                          Row(
                            children: const [
                              Text('2022-02-22 ', style: TextStyle(fontSize: 20, ), ),
                              Text('\$1,825,000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                              SizedBox( width: 10.0, ),
                              Text('TERMINATED', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kPrimaryColor),),
                              Divider( height: 28,  thickness: 0.8, color: Color(0xFF0BB48B), ),
                            ],
                          ),
                          const Divider( height: 14.0,  thickness: 0.8, color: kPrimaryColor, ), */
                        ],
                      ),
                    ),
                  ],  
                ),

                // OVERLAYS
                /* Container(
                  //width: 310,
                  //height: 207, 
                  padding: const EdgeInsets.fromLTRB( 0, 15, 50, 0),
                  alignment: Alignment.topRight,  
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 1.0,
                        top: 2.0,
                        child: Icon(Icons.favorite_outlined, color: Colors.black26, size: 32),
                      ),
                      InkWell(
                        child: const Icon(Icons.favorite_outlined, color: Color(0xFFffffff), size: 32),
                        onTap: () {
                          //print('object');
                        },
                      )
                    ],
                  ),                  
                ), */
                Container(
                  //width: 310,
                  //height: 207, 
                  padding: const EdgeInsets.fromLTRB( 0, 15, 10, 0),
                  alignment: Alignment.topRight,  
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 1.0,
                        top: 2.0,
                        child: Icon(Icons.filter_9_plus_outlined, color: Colors.black26, size: 32),
                      ),
                      InkWell(
                        child: const Icon(Icons.filter_9_plus_outlined, color: Color(0xFFffffff), size: 32),
                        onTap: () {
                          Navigator.pushNamed(context, 'card_images_screen', arguments: listing);
                          //print('object');
                        },
                      )                              
                    ],
                  ),                          
                ),
                Container(
                  //width: 310,
                  height: 370,
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    child: const Image(image: AssetImage('assets/play&learn_chip_85h.png'), ),
                    onTap: () {
                      //print('object');
                    },
                  ),
                ),
                Container(
                  width: 170,
                  padding: const EdgeInsets.only( left: 20.0, top: 10.0, ),
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                    /* style: ButtonStyle( 
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF2E3191)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(10, 0, 10, 0)),
                    ), */
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF2E3191),
                      minimumSize: const Size(140.0, 28.0),
                      padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onPressed: () {
                      //Navigator.pushNamed(context, 'details', arguments: movie);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined, size: 16,),
                        const SizedBox( width: 5, ),
                        Text( finalDiffDt , style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  )
                ),                
    
              ],
            ),
          );
  }
}