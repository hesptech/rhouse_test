import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/response_listings.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

///Widget used to display the icons to see more pictures of the residence.
class MapCardSingleStack  {
  Widget favorite(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 70),
      alignment: Alignment.topRight,
      child: Stack(
        children: [
          InkWell(
            child: const Icon(Icons.favorite_rounded, color: Color(0xFFffffff), size: 35),
            onTap: () {
              
            },
          )
        ],
      ),
    );
  }

  Widget showImages(BuildContext context, Listing listing) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 20),
      alignment: Alignment.topRight,
      child: Stack(
        children: [
          const Positioned(
            left: 1.0,
            top: 2.0,
            child: Icon(Icons.filter_9_plus_outlined, color: Colors.black26, size: 30),
          ),
          InkWell(
            child: const Icon(Icons.filter_9_plus_outlined, color: Color(0xFFffffff), size: 35),
            onTap: () {
              Navigator.pushNamed(context, 'card_images_screen', arguments: listing);
            },
          )
        ],
      ),
    );
  }

  Widget entryDate(DataFormatter dataFormatted,  bool loggedIn) {
    return Row(
      children: [
        if (loggedIn == true)
          Container(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 10.0,
              ),
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  minimumSize: const Size(140.0, 28.0),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, 'details', arguments: listing);
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
                    Text(dataFormatted.listEntryDate, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400))
                  ],
                ),
              )),
        if (loggedIn == false)
          Container(
              width: 310,
              height: 430,
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, 'details', arguments: listing);
                },
                child: const Text('Login required'),
              )),
      ],
    );
  }
}
