import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/modules/cards/card_details_full/card_details_stack.dart';
import 'package:flutter_black_white/screens/map_property_screen.dart';
import 'package:flutter_black_white/widgets/cards_carousel_slider.dart';

class CardDetailsTop extends StatelessWidget {
  final Listing listing;

  const CardDetailsTop(this.listing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(listing);
    final screenSize = MediaQuery.of(context).size;
    //final String images = listing.images?.first ?? '';

    return Container(
      margin: const EdgeInsets.all(14),
      child: Stack(
        children: [
          Column(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: CardsCarouselSlider(listing),
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
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        height: 30,
                        child: FittedBox(
                          child: Text(
                            dataFormatted.addressCity, 
                            style: const TextStyle(
                              fontWeight: FontWeight.w400, 
                              color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          CardDetailsStack(listing),
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
          Consumer<FilterProvider>(
            builder: (context, currentFilter, child) => Container(
              //width: 310,
              height: 370,
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: InkWell(
                child: const Image(
                  image: AssetImage('assets/play&learn_chip_85h.png'),
                ),
                onTap: () {
                  currentFilter.cardGamePriceDisplay = true;
                  Navigator.pushNamed(context, 'game_screen',arguments: {'listing': listing});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
