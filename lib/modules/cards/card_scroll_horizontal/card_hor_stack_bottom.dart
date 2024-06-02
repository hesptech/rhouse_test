import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/providers/repliers_favorites.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/screens/map_property_screen.dart';

class CardHorStackBottom extends StatefulWidget {

  final Listing listing;

  const CardHorStackBottom( this.listing, {super.key});

  @override
  State<CardHorStackBottom> createState() => _CardHorStackBottomState();
}

class _CardHorStackBottomState extends State<CardHorStackBottom> {

  bool toggle = false;

  @override
  Widget build(BuildContext context) {

    const loggedIn = true;
    final bool statusActive = widget.listing.status == 'A' ? true : false ;
    final filterProvider = Provider.of<FilterProvider>(context);
    final repliersFavorites = Provider.of<RepliersFavorites>(context);

    return loggedIn == true
      ? 
      Stack(
        //alignment: Alignment.topCenter,
        children: [

          Container(
            width: 310,
            height: 207, 
            padding: const EdgeInsets.fromLTRB( 20, 0, 50, 5),
            alignment: Alignment.bottomLeft,  
            child: InkWell(
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Icon(Icons.map_outlined, color: kSecondaryColor, size: 30),
              ),
              onTap: () {
                Navigator.pushNamed(context, MapPropertyScreen.pathScreen, arguments: {'listing': widget.listing});
              },
            ),                      
          ),


          Container(
            width: 310,
            height: 207, 
            padding: const EdgeInsets.fromLTRB( 0, 160, 195, 0),
            alignment: Alignment.topRight,  
            child: Stack(
              children: [
                const Positioned(
                  left: 11.0,
                  top: 11.0,
                  child: Icon(
                    Icons.favorite_border_outlined, color: Colors.black26, size: 30),
                ),
                Material(
                  color: Colors.transparent,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(50),
                  child: IconButton(
                    splashColor: kPrimaryColor.withOpacity(0.8),
                    highlightColor: kPrimaryColor,
                    icon: filterProvider.favoritesTemp.contains(widget.listing.mlsNumber?? '')
                      ? const Icon(Icons.favorite, size: 30, color: Colors.white,)
                      : const Icon(Icons.favorite_border, size: 30, color: Colors.white,),
                    onPressed: () {
                      setState(() {
                        // Here we changing the icon.
                        toggle = !toggle;
                        if(!filterProvider.favoritesTemp.contains(widget.listing.mlsNumber?? '')) {
                          filterProvider.favoritesTemp.add(widget.listing.mlsNumber?? '');
                          repliersFavorites.getInsertFavorites( Preferences.userId.toString(), widget.listing.mlsNumber?? '');
                        } else {
                          filterProvider.favoritesTemp.removeWhere((String name) => name == widget.listing.mlsNumber);
                          repliersFavorites.getDeleteFavorites( Preferences.userId.toString(), widget.listing.mlsNumber?? '');
                        }

                        if(!filterProvider.favoritesTemp.contains('0')){
                          filterProvider.favoritesTemp.add('0');
                        }                        
                      });
                    }
                  ),
                ),
              ],
            ),                        
          ),
          Container(
            width: 310,
            height: 207, 
            padding: const EdgeInsets.fromLTRB( 0, 170, 155, 0),
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
                    Navigator.pushNamed(context, 'card_images_screen', arguments: widget.listing);
                    //print('object');
                  },
                )
              ],
            ),
          ),

          if (statusActive) Container(
            width: 310,
            height: 207,
            //padding: const EdgeInsets.all(5.0),
            alignment: Alignment.bottomRight,
            child: InkWell(
              child: const Image(image: AssetImage('assets/logos/play&learn_chip_53h.png'), ),
              onTap: () {
                Provider.of<FilterProvider>(context, listen: false).cardGamePriceDisplay = true;
                Navigator.pushNamed(context, 'game_screen',arguments: {'listing': widget.listing});
              },
            ),
          )         
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