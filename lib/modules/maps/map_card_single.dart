import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/maps/widgets/map_card_single_box.dart';
import 'package:flutter_black_white/modules/maps/widgets/map_card_single_stack.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class MapCardSingle extends StatelessWidget {
  final Listing listing;
  final bool loggedIn = true;

  const MapCardSingle({
    required this.listing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataFormatted = DataFormatter(listing);

    const loggedIn = true;
    const blurImg = loggedIn == false ? 5.0 : 0.0;
    final screenSize = MediaQuery.of(context).size;

    // Gen. Info
    final String images = listing.images?.first ?? '';
    final String propertyType = listing.details?.propertyType ?? '';
    final String numBathrooms = listing.details?.numBathrooms ?? '';

    String neighborhood = listing.address?.neighborhood ?? '';
    final String city = listing.address?.city ?? '';
    final String cityArea = listing.address?.area == 'Toronto' ? 'Toronto' : city;

    if (neighborhood == 'Waterfront Communities C1') {
      neighborhood == 'Waterfront Communities West';
    } else if (neighborhood == 'Waterfront Communities C8') {
      neighborhood == 'Waterfront Communities East';
    }

    final String finalAddress2 = '$neighborhood, $cityArea';
    String finalAddress3 = '';
    if (finalAddress2.length > 30) {
      finalAddress3 = '${finalAddress2.substring(0, 30)}...';
    } else {
      finalAddress3 = finalAddress2;
    }

    return LayoutBuilder(
      builder: (context, constrains) {
        return FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    _imageBackground(images, blurImg, context),
                    Positioned(bottom: 155,  child: MapCardSingleStack().entryDate(dataFormatted, loggedIn)),
                    Positioned(left: 270, bottom: 160, child: MapCardSingleStack().favorite(context)),
                    Positioned(left: 320, bottom: 157, child: MapCardSingleStack().showImages(context, listing)),
                  ],
                ),
                SizedBox(
                  width: 410,
                  child: _infoBasic(dataFormatted, propertyType, screenSize, finalAddress3, numBathrooms),
                )                  
              ],
            ));
      }
    );
  }

  Widget _imageBackground(String images, double blurImg, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blurImg, sigmaY: blurImg),
        child: GestureDetector(
          onTap: () {
            if (loggedIn == true) {
              Navigator.pushNamed(context, 'card_details_full_screen', arguments: listing);
            } else {
              //Navigator.restorablePopAndPushNamed(context, '/');
            }
          },
          child: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage('$kRepliersCdn$images?w=500'),
            width: 380,
            height: 207,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 300),
          ),
        ),
      ),
    );
  }

  Widget _infoBasic(
      DataFormatter dataFormatted, String propertyType, Size screenSize, String finalAddress3, String numBathrooms) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: 15.0, top: 0, right: 16.0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      ' ${dataFormatted.listPrice}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2E3191)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF2E3191)),
                    ),
                    child: Text(
                      propertyType,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2E3191),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 20.0, top: 0, right: 10.0, bottom: 0),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF0BB48B),
                    size: 22,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Container(
                      constraints: BoxConstraints(maxWidth: screenSize.width - 130),
                      child: Text(
                        dataFormatted.address,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16, color: Color(0xFF58595B)),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: 35.0, top: 0, right: 10.0, bottom: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    finalAddress3,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF58595B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MapCardSingleBox(numBedrooms: dataFormatted.numBedrooms, numBathrooms: numBathrooms, numParkingSpaces: dataFormatted.numParkingSpaces)
          // _characteristicsProperty(dataFormatted, numBathrooms),
        ],
      ),
    );
  }

}
