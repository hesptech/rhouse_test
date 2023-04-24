import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/cards/card_details_expansions.dart';
import 'package:flutter_black_white/modules/cards/card_details_map.dart';
import 'package:flutter_black_white/modules/cards/card_details_top.dart';



class CardDetailsFullScreen extends StatelessWidget {
  const CardDetailsFullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Listing listing = ModalRoute.of(context)?.settings.arguments! as Listing;
    //print(listing.listingClass);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Image(image: AssetImage('assets/r_logo_112x38.png'), ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon( Icons.search_outlined, size: 30, ),
          ), 
          const SizedBox( width: 10,)         
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 5,
              color: kSecondaryColor,        
            ),
            CardDetailsTop( listing ),
            const SizedBox( height: 22.0, ),
            const CardDetailsMap(),
            const SizedBox( height: 22.0, ),
            CardDetailsExpansions( listing ),           
          ],
        ),
      ),
    );
  }
}
