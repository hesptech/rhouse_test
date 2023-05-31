import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class MapCardSingle extends StatelessWidget {
  final Listing listing;
  final bool loggedIn = true;

  const MapCardSingle(
    this.listing, {
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

    return Container(
        decoration: BoxDecoration(border: Border.all(color: const Color(0XFF2D368F))),
        child: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: blurImg, sigmaY: blurImg),
              child: GestureDetector(
                onTap: () {
                  if (loggedIn == true) {
                    Navigator.pushNamed(context, 'card_details_full_screen', arguments: listing);
                  } else {
                    //Navigator.restorablePopAndPushNamed(context, '/');
                  }
                },
                child: Column(
                  children: [
                    // IMAGE box
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: <Widget>[_imageBackground(images), _favorite(context), _showImages(context)],
                      ),
                    ),

                    _infoBasic(dataFormatted, propertyType, screenSize, finalAddress3, numBathrooms),

                    //Text('\n ${listing.listingClass}')
                  ],
                ),
              ),
            ),
            _entryDate(dataFormatted)
          ],
        ));
  }

  FadeInImage _imageBackground(String images) {
    return FadeInImage(
      placeholder: const AssetImage('assets/no-image.jpg'),
      image: NetworkImage('https://cdn.repliers.io/$images?w=500'),
      width: 380,
      height: 207,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _favorite(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 70),
      alignment: Alignment.topRight,
      child: Stack(
        children: [
          InkWell(
            child: const Icon(Icons.favorite_rounded, color: Color(0xFFffffff), size: 35),
            onTap: () {
              Navigator.pushNamed(context, 'card_images_screen', arguments: listing);
            },
          )
        ],
      ),
    );
  }

  Widget _showImages(BuildContext context) {
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

  Widget _entryDate(DataFormatter dataFormatted) {
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
                  backgroundColor: const Color(0xFF2E3191),
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
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF5f68be)),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, 'details', arguments: listing);
                },
                child: const Text('Login required'),
              )),
      ],
    );
  }

  Widget _infoBasic(
      DataFormatter dataFormatted, String propertyType, Size screenSize, String finalAddress3, String numBathrooms) {
    return SizedBox(
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              // width: 350.0,
              padding: const EdgeInsets.only(left: 10.0, top: 0, right: 10.0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      ' ${dataFormatted.listPrice}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF2E3191)),
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
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10.0, top: 0, right: 10.0, bottom: 0),
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
                  ConstrainedBox(
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
          Container(
            padding: const EdgeInsets.only(left: 35.0, top: 0, right: 10.0, bottom: 10),
            child: Row(
              children: [
                const SizedBox(
                  width: 2,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenSize.width - 130),
                  child: Text(
                    finalAddress3,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF58595B),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _characteristicsProperty(dataFormatted, numBathrooms),
        ],
      ),
    );
  }

  Widget _characteristicsProperty(DataFormatter dataFormatted, String numBathrooms) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 35.0,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFF0BB48B)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.king_bed_outlined,
                  color: Color(0xFF0BB48B),
                  size: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    dataFormatted.numBedrooms,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF666597),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 68.0,
          height: 35.0,
          padding: const EdgeInsets.all(3.0),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFF0BB48B)),
              left: BorderSide(color: Color(0xFF0BB48B)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shower_outlined,
                color: Color(0xFF0BB48B),
                size: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Text(
                  numBathrooms,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF666597),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 68.0,
          height: 35.0,
          padding: const EdgeInsets.all(3.0),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFF0BB48B)),
              left: BorderSide(color: Color(0xFF0BB48B)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.directions_car_filled_outlined,
                color: Color(0xFF0BB48B),
                size: 28,
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Text(
                  dataFormatted.numParkingSpaces,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF666597),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 35.0,
            width: 112.0,
            padding: const EdgeInsets.all(0.0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFF0BB48B)),
                left: BorderSide(color: Color(0xFF0BB48B)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.straighten,
                  color: Color(0xFF0BB48B),
                  size: 28,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    dataFormatted.lotSqft,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF666597),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
