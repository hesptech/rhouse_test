import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/providers/repliers_listing_mls.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/cards/cards.dart';



class CardDetailsFullScreen extends StatelessWidget {
  const CardDetailsFullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Listing listing = ModalRoute.of(context)?.settings.arguments! as Listing;
    //print(listing.listingClass);
    final repliersHistory = Provider.of<RepliersListingMls>(context);

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
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 5,
              color: kSecondaryColor,        
            ),
            CardDetailsTop( listing ),
            const SizedBox( height: 14,),
            CardDetailsHistory( 
              //listing, 
              //listing.mlsNumber, 
              onInit: () => repliersHistory.initGetDisplay(),
              onHistory: () => repliersHistory.getListingHistory( listing.mlsNumber ), 
            ),
            const SizedBox( height: 28,),
            const CardDetailsMap(),
            const SizedBox( height: 22.0, ),
            CardDetailsExpansions( listing ), 
            /* Consumer<FilterProvider>(
              builder: (context, currentFilter, child) => ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
                childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                title: const Text('PROPERTY TYPE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                trailing: Icon(
                  _openCloseIcons[0] ? Icons.remove : Icons.add,
                  color: kSecondaryColor,
                ),
                children: currentFilter.filterProvider == "residential" ? [const FiltersPropertyHouse()] : [const FiltersPropertyCondo()],
                onExpansionChanged: (bool expanded) {
                  setState(() => _openCloseIcons[0] = expanded );
                  if (expanded == false) {
                    setState(() => _openCloseIcons[1] = false );
                    setState(() => _openCloseIcons[2] = false );
                  }
                },
              ),
            ), */         
          ],
        ),
      ),
    );
  }
}
