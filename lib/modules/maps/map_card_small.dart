import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/screens/map_screen.dart';
import 'package:flutter_black_white/utils/card_full_description_arguments.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

///Widget that displays a summary information card and is used to list properties on the map.
class MapCardSmall extends StatelessWidget {
  final Listing listing;
  final bool loggedIn = true;

  const MapCardSmall(
    this.listing, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataFormatter dataFormatted = DataFormatter(listing);

    const bool loggedIn = true;
    const double blurImg = loggedIn == false ? 5.0 : 0.0;

    final String images = listing.images?.first ?? '';

    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: kPrimaryColor, width: 2),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(0),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: blurImg, sigmaY: blurImg),
              child: GestureDetector(
                onTap: () {
                  if (loggedIn) {
                    Navigator.pushNamed(context, 'card_details_full_screen', arguments: CardFullDescriptionArguments(listing, MapScreen.pathScreen));
                  }
                },
                child: Column(
                  children: [
                    Flexible(
                      // flex: 1,
                      child: Row(
                        children: [
                          _columnHead(listing, dataFormatted, images),
                          Expanded(child: _detailsBody(dataFormatted, context)),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _entryDateWidget(listing, dataFormatted),
                        Expanded(child: _detailsResidence(dataFormatted)),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }

  Widget _detailsBody(DataFormatter dataFormatted, BuildContext context) {
    String neighborhood = listing.address?.neighborhood ?? '';
    final String city = listing.address?.city ?? '';
    final String cityArea = listing.address?.area == 'Toronto' ? 'Toronto' : city;

    if (neighborhood == 'Waterfront Communities C1') {
      neighborhood == 'Waterfront Communities West';
    }

    if (neighborhood == 'Waterfront Communities C8') {
      neighborhood == 'Waterfront Communities East';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 5.0, top: 5, right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              '${dataFormatted.listPrice} ',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.justify,
              softWrap: true,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            dataFormatted.address,
            maxLines: 2,
            softWrap: true,
            style: const TextStyle(fontSize: 10, color: Color(0xFF58595B)),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '$neighborhood, $cityArea',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF58595B),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5.0),
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor),
            ),
            child: Text(
              listing.details?.propertyType ?? '',
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailsResidence(DataFormatter dataFormatted) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 3),
          width: 60.0,
          height: 20.0,
          margin: const EdgeInsets.only(bottom: 5),
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.king_bed_outlined,
                  color: kSecondaryColor,
                  size: 20,
                ),
                const SizedBox(
                  width: 3,
                  height: 2,
                ),
                Expanded(
                  child: Text(
                    dataFormatted.numBedrooms,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color(0xFF666597),
                      fontWeight: FontWeight.bold,
                      fontSize: 10.14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 50.0,
          height: 20.0,
          padding: const EdgeInsets.only(left: 3),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: kSecondaryColor),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shower_outlined,
                  color: kSecondaryColor,
                  size: 20,
                ),
                const SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Text(
                    listing.details?.numBathrooms ?? '',
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color(0xFF666597),
                      fontWeight: FontWeight.bold,
                      fontSize: 10.14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 40.0,
          height: 20.0,
          padding: const EdgeInsets.only(left: 3),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: kSecondaryColor),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.directions_car_filled_outlined,
                  color: kSecondaryColor,
                  size: 20,
                ),
                const SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Text(
                    dataFormatted.numParkingSpaces,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color(0xFF666597),
                      fontWeight: FontWeight.bold,
                      fontSize: 10.14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }

  Widget _columnHead(Listing listing, DataFormatter dataFormatted, String images) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: FadeInImage(
            placeholder: const AssetImage('assets/no_images_subs/no-image.jpg'),
            image: NetworkImage('$kRepliersCdn$images?class=small'),
            width: 145,
            height: 116.8,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 300),
          ),
        ),
        if(dataFormatted.openHouse != '') Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              alignment: Alignment.bottomLeft,
              backgroundColor: kPrimaryColor,
              minimumSize: const Size(65.0, 22.0),
              padding: const EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 5.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              //Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: Row(
              children: [
                const Text(
                  'OPEN: ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, height: 1.0, color: Colors.yellow),
                ),
                Text(
                  dataFormatted.openHouse, 
                  style: const TextStyle(fontSize: 11,  height: 1.0, color: Colors.yellow),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _entryDateWidget(Listing listing, DataFormatter dataFormatted) {
    if (loggedIn == true) {
      return Container(
          margin: const EdgeInsets.only(top: 5, left: 10),
          width: 130,
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: kPrimaryColor,
                size: 15,
              ),
              const SizedBox(
                width: 2,
              ),
              Expanded(
                child: Text(dataFormatted.listEntryDate,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: kPrimaryColor)),
              )
            ],
          ));
    }

    return Container(
        alignment: Alignment.topLeft,
        height: 25,
        margin: const EdgeInsets.only(top: 5, left: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
          onPressed: () {
            //Navigator.pushNamed(context, 'details', arguments: listing);
          },
          child: const Text(
            'Login required',
            style: TextStyle(fontSize: 11),
          ),
        ));
  }
}
