import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/screens/map_property_screen.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/cards/card_details_box.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class CardDetailsTop extends StatelessWidget {
  final Listing listing;

  const CardDetailsTop(this.listing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataFormatted = DataFormatter(listing);

    String neighborhood = listing.address?.neighborhood ?? '';
    final String city = listing.address?.city ?? '';
    //final String area = listing.address?.area?? '';
    final String cityArea = listing.address?.area == 'Toronto' ? 'Toronto' : city;
    final String finalAddress2 = '$neighborhood, $cityArea';
    String finalAddress3 = '';
    if (finalAddress2.length > 25) {
      finalAddress3 = '${finalAddress2.substring(0, 25)}...';
    } else {
      finalAddress3 = finalAddress2;
    }

    final screenSize = MediaQuery.of(context).size;
    final String images = listing.images?.first ?? '';

    return Container(
      margin: const EdgeInsets.all(14),
      child: Stack(
        children: [
          Column(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: FadeInImage(
                  height: 300,
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  //image: AssetImage('assets/house_500x300.jpg'),
                  image: NetworkImage('$kRepliersCdn$images?w=500'),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 300),
                ),
                //child: const Placeholder( fallbackHeight: 300.0, ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: screenSize.width - 110),
                          child: Text(
                            dataFormatted.address,
                            textAlign: TextAlign.left,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          finalAddress3,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: kPrimaryColor),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    CardDetailsBox(listing),
                  ],
                ),
              ),
            ],
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
          Container(
            //width: 310,
            height: 370,
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.bottomRight,
            child: InkWell(
              child: const Image(
                image: AssetImage('assets/play&learn_chip_85h.png'),
              ),
              onTap: () {
                //print('object');
              },
            ),
          ),
          Container(
              width: 200,
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 10.0,
              ),
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
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
                      dataFormatted.listEntryDate,                  
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              )),
          Container(
            width: 310,
            height: 280,
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.bottomLeft,
            child: InkWell(
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Icon(Icons.map_outlined, color: kSecondaryColor, size: 30),
              ),
              onTap: () {
                Navigator.pushNamed(context, MapPropertyScreen.pathScreen, arguments: {'listing': listing});
              },
            ),
          ),
        ],
      ),
    );
  }
}
