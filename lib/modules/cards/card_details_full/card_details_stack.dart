import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/providers/repliers_favorites.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class CardDetailsStack extends StatefulWidget {
  final Listing listing;

  const CardDetailsStack(this.listing, {super.key});

  @override
  State<CardDetailsStack> createState() => _CardDetailsStackState();
}

class _CardDetailsStackState extends State<CardDetailsStack> {

  bool toggle = false;

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(widget.listing);
    final bool statusActive = widget.listing.status == 'A' ? true : false;

    final filterProvider = Provider.of<FilterProvider>(context);
    final repliersFavorites = Provider.of<RepliersFavorites>(context);

    return Stack(
      children: [
        Container(
          width: 200,
          padding: const EdgeInsets.only(
            left: 10.0,
            top: 5.0,
          ),
          alignment: Alignment.topLeft,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: statusActive ? kPrimaryColor : kWarningColor,
              minimumSize: const Size(140.0, 28.0),
              padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            onPressed: () {
              //Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  statusActive
                  ? dataFormatted.listEntryDate
                  : dataFormatted.listEntryDateSold,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
        Container(
          //width: 310,
          //height: 207,
          padding: const EdgeInsets.fromLTRB(0, 5, 50, 0),
          alignment: Alignment.topRight,
          child: Stack(
            children: [
              const Positioned(
                left: 9.0,
                top: 11.0,
                child: Icon(Icons.favorite_border_outlined, color: Colors.black26, size: 32),
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
                        repliersFavorites.getInsertFavorites( '2', widget.listing.mlsNumber?? '');
                      } else {
                        filterProvider.favoritesTemp.removeWhere((String name) => name == widget.listing.mlsNumber);
                        repliersFavorites.getDeleteFavorites( '2', widget.listing.mlsNumber?? '');
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
          //width: 310,
          //height: 207,
          padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
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
                  Navigator.pushNamed(context, 'card_images_screen', arguments: widget.listing);
                  //print('object');
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}