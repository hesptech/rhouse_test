import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class CardHorizontalStack extends StatelessWidget {

  final Listing listing;

  const CardHorizontalStack( this.listing, {super.key});

  @override
  Widget build(BuildContext context) {

    const loggedIn = true;
    final dataFormatted = DataFormatter(listing);

    return loggedIn == true
      ? 
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0,),
            alignment: Alignment.topLeft,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
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
          Container(
            width: 310,
            height: 207, 
            padding: const EdgeInsets.fromLTRB( 0, 25, 40, 0),
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
            padding: const EdgeInsets.fromLTRB( 0, 25, 0, 0),
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
        ],
      )
      : 
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
      )
      ;
  }
}