import 'package:flutter/material.dart';
//import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';


class CardDetailsBox extends StatelessWidget {
  const CardDetailsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final Listing listing = ModalRoute.of(context)?.settings.arguments! as Listing;
    //print(listing.listingClass);

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text('Listed for: ', style: TextStyle(fontSize: 16, ), ),   
                    Text('\$1,500.000', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2E3191), ), ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric( vertical: 2, horizontal: 5.0 ),
                  /* decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF2E3191)),
                  ), */
                  child: const Text('Detached', style: TextStyle(fontSize: 14, color: kPrimaryColor, fontWeight: FontWeight.bold),),
                ),                         
              ],                   
            ),
          ),
          const Divider( height: 0,  thickness: 0.8, color: Color(0xFF0BB48B), ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              SizedBox(
                //width: 75.0,
                height: 40.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric( vertical: 5.0, horizontal: 10.0 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.king_bed_outlined, color: Color(0xFF0BB48B), size: 30,),
                      SizedBox(width: 5,),
                      Text('3', style: TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), ),                                  
                    ],
                  ),
                ),
              ),
              Container(
                //width: 75.0,
                height: 40.0,
                padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                  border: Border(

                    left: BorderSide(color: Color(0xFF0BB48B)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox( width: 10,),
                    Icon(Icons.shower_outlined, color: Color(0xFF0BB48B), size: 30,),
                    SizedBox(width: 5,),
                    Text('2+1', style: TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), ),                                  
                  ],
                ),
              ),
              Container(
                //width: 75.0,
                height: 40.0,
                padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Color(0xFF0BB48B)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox( width: 10,),
                    Icon(Icons.directions_car_filled_outlined, color: Color(0xFF0BB48B), size: 28,),
                    SizedBox(width: 5,),
                    Text('2', style: TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), ),                                    
                  ],
                ),
              ),
              Container(
                width: 120.0,
                height: 40.0,
                //width: 104.0,
                padding: const EdgeInsets.all(3.0),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Color(0xFF0BB48B)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //Icon(Icons.straighten_outlined, color: Color(0xFF0BB48B), size: 24,),
                    SizedBox(width: 5,),
                    Text('8,900', style: TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), )                                    
                  ],
                ),
              ),                          
            ],                          
          ),
          const Divider( height: 0,  thickness: 0.8, color: Color(0xFF0BB48B), ),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Listing #: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kSecondaryColor),),
                Text('W5922867', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: kPrimaryColor),),
              ],
            ),
          ),
          const Divider( height: 0,  thickness: 0.8, color: Color(0xFF0BB48B), ),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Direction/main: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kSecondaryColor),),
                Text('Young and St. Claire', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: kPrimaryColor),),
              ],
            ),
          )
        ],
      ),
    );
  }
}