import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/providers/repliers_favorites.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


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

    final dataFormatted = DataFormatter(widget.listing);
    final filterProvider = Provider.of<FilterProvider>(context);
    final repliersFavorites = Provider.of<RepliersFavorites>(context);

    final Map<String, OpenHouse>? openHouseData = widget.listing.openHouse;
    //final openHouseDate = OpenHouseDates(listing: widget.listing);

    String openHouseDateDisplay = '';

    for (var value in openHouseData!.values) {
      if(value.date.isNotEmpty && value.date != '') {
      //print('value date:  ${value.date}');
        //var parsedDate = DateTime.parse(value.date!.substring(0, 10));
        DateTime parsedDate = DateTime.parse(value.date);
        String dateFormat = DateFormat('dd-MM-yyyy').format(parsedDate);

        DateTime now = DateTime.now();
        DateFormat formatter = DateFormat('dd-MM-yyyy');
        String formatted = formatter.format(now);
        
        //print('$formatted $dateFormat');

        if(formatted == dateFormat) {
          //print('after: ${value.date!.substring(0, 10)}');
          //openHouseDateDisplay = 'after ${dateFormat}';
          openHouseDateDisplay = 'TODAY';
          break;
        } else if (parsedDate.isAfter(DateTime.now())){
          //print('after: ${value.date!.substring(0, 10)}');
          //openHouseDateDisplay = 'after ${dateFormat}';
          String dateWeekFormat = DateFormat('EEEE').format(parsedDate);
          String dateDD = DateFormat('dd').format(parsedDate);
          //openHouseDateDisplay = dateFormat;
          openHouseDateDisplay = '$dateWeekFormat $dateDD';
          break;
        } else if (parsedDate.isBefore(DateTime.now()) || dateFormat != ''){
          //print('before: ${parsedDate}');
          //openHouseDateDisplay = 'before ${parsedDate}';
          //break;
        }
      } else {
        //openHouseDateDisplay = '';
      }
    }


    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric( horizontal: 20.0, vertical: 10.0 ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
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
              ),
              Row(
                children: [
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
          if(openHouseDateDisplay != '') Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSecondaryColor,
                  minimumSize: const Size(140.0, 28.0),
                  padding: const EdgeInsets.all( 0.0 ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, 'details', arguments: movie);
                },
                child: Row(
                  children: [
                    //const Icon(Icons.groups_outlined, size: 20),
                    const Text('OPEN', style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      openHouseDateDisplay,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,),
                    ),
                  ],
                ),
              ),              
            ],
          )
        ],
      ),
    );
  }
}
