import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class CardDetailsStack extends StatelessWidget {
  final Listing listing;

  const CardDetailsStack(this.listing, {super.key});

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(listing);
    final bool statusActive = listing.status == 'A' ? true : false;

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
          padding: const EdgeInsets.fromLTRB(0, 15, 50, 0),
          alignment: Alignment.topRight,
          child: Stack(
            children: [
              const Positioned(
                left: 1.0,
                top: 2.0,
                child: Icon(Icons.favorite_border_outlined, color: Colors.black26, size: 32),
              ),
              InkWell(
                child: const Icon(Icons.favorite_border_outlined, color: Color(0xFFffffff), size: 32),
                onTap: () {
                  Navigator.pushNamed(context, 'card_images_screen', arguments: listing);
                },
              )
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
                  Navigator.pushNamed(context, 'card_images_screen', arguments: listing);
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