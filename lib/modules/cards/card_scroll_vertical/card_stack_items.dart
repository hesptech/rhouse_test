import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/providers/repliers_favorites.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/cards/cards_widgets/open_house_dates.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';


class CardStackItems extends StatefulWidget {

  final Listing listing;

  const CardStackItems( this.listing, {Key? key}) : super(key: key);

  @override
  State<CardStackItems> createState() => _CardStackItemsState();
}

class _CardStackItemsState extends State<CardStackItems> {

  bool toggle = false;

  @override
  Widget build(BuildContext context) {

    final filterProvider = Provider.of<FilterProvider>(context);
    final repliersFavorites = Provider.of<RepliersFavorites>(context);
    final dataFormatted = DataFormatter(widget.listing);

    return Container(
      alignment: Alignment.topLeft,
      //mainAxisAlignment: dataFormatted.openHouse != '' ? MainAxisAlignment.center : MainAxisAlignment.start,
      //padding: const EdgeInsets.symmetric( horizontal: 20.0, vertical: 20.0 ),
      child: Column(
        children: [
          Container(
            height: 28,
            margin: dataFormatted.openHouse != '' ? const EdgeInsets.only(top: 20.0) : const EdgeInsets.only(top: 20.0, left: 20.0),
            child: OpenHouseDates(listing: widget.listing, cardType: 'vertical'),
          ),
          const SizedBox(height: 135.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  minimumSize: const Size(140.0, 28.0),
                  padding: const EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, 'details', arguments: movie);
                },
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined, size: 16),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      dataFormatted.listEntryDate,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400,),
                    ),
                  ],
                ),
              ), */
              Row(
                children: [
              const SizedBox( width: 70.0,),
                  Stack(
                    children: [
                      const Positioned(
                        left: 11.0,
                        top: 11.0,
                        child: Icon(Icons.favorite_border_outlined, color: Colors.black26, size: 30),
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
                  const SizedBox(width: 7.0,),
                  Stack(
                    children: [
                      const Positioned(
                        left: 1.0,
                        top: 2.0,
                        child: Icon(Icons.filter_9_plus_outlined, color: Colors.black26, size: 30),
                      ),
                      InkWell(
                        child: const Icon(Icons.filter_9_plus_outlined, color: Color(0xFFffffff), size: 30),
                        onTap: () {
                          Navigator.pushNamed(context, 'card_images_screen', arguments: widget.listing);
                          //print('object');
                        },
                      )                              
                    ],
                  )              
                ],
              ),
            ],
          ),
          //OpenHouseDates(listing: widget.listing),
        ],
      ),
    );
  }
}
