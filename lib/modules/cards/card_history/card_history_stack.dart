import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

//import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';

class CardHistoryStack extends StatefulWidget {
  final Listing listing;
  final String lastStatusHistory;
  final String dateHistory;

  const CardHistoryStack(this.listing, this.lastStatusHistory, this.dateHistory, {super.key});

  @override
  State<CardHistoryStack> createState() => _CardHistoryStackState();
}

class _CardHistoryStackState extends State<CardHistoryStack> {

  bool toggle = false;

  @override
  Widget build(BuildContext context) {

    //final bool statusActive = lastStatusHistory == 'SOLD' ? true : false;

    return Stack(
      children: [
        Container(
          width: 212,
          padding: const EdgeInsets.only(
            left: 10.0,
            top: 5.0,
          ),
          alignment: Alignment.topLeft,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kWarningColor,
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
                  '${widget.lastStatusHistory} ${widget.dateHistory}',
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
        /* Container(
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
              Consumer<FilterProvider>(
                builder: (context, currentFavorite, child) => IconButton(
                  icon: currentFavorite.favoritesTemp.contains(widget.listing.mlsNumber?? '')
                    ? const Icon(Icons.favorite, size: 30, color: Colors.white,)
                    : const Icon(Icons.favorite_border, size: 30, color: Colors.white,),
                  onPressed: () {
                    setState(() {
                      // Here we changing the icon.
                      toggle = !toggle;
                      if(toggle == true) {
                        currentFavorite.favoritesTemp.add(widget.listing.mlsNumber?? '');
                      } else {
                        currentFavorite.favoritesTemp.removeWhere((String name) => name == widget.listing.mlsNumber);
                      }
                    });
                  }
                )
              ),
            ],
          ),
        ), */
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
