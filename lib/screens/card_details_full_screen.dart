import 'package:flutter/material.dart';
import 'package:flutter_black_white/screens/screens.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/providers/repliers_listing_mls.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/cards/card_details_full/cards.dart';

class CardDetailsFullScreen extends StatelessWidget {
  const CardDetailsFullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Listing listing = ModalRoute.of(context)?.settings.arguments! as Listing;
    final repliersHistory = Provider.of<RepliersListingMls>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Image(
          image: AssetImage('assets/r_logo_112x38.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_outlined,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 5,
              color: kSecondaryColor,
            ),
            CardDetailsTop(listing),
            CardDetailsBox(listing),
            const SizedBox(
              height: 14,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, ContactAgentScreen.pathScreen);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
                child: Container(
                  height: 60,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, style: BorderStyle.solid, color: kPrimaryColor),
                  ),
                  child: const Align(alignment: Alignment.center, child: Text("CONTACT AGENT", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            CardDetailsHistory(
              onInit: () => repliersHistory.initGetDisplay(),
              onHistory: () => repliersHistory.getListingHistory(listing.mlsNumber),
            ),
            const SizedBox(
              height: 28,
            ),
            CardDetailsMap(listing: listing),
            const SizedBox(
              height: 22.0,
            ),
            CardDetailsExpansions(listing),
            /* Consumer<FilterProvider>(
              builder: (context, currentFilter, child) => ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
                childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                title: const Text('PROPERTY TYPE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                trailing: Icon(
                  _openCloseIcons[0] ? Icons.remove : Icons.add,
                  color: kSecondaryColor,
                ),
                children: currentFilter.filterProvider == "residential" ? [const FiltersPropertyHouse()] : [const FiltersPropertyCondo()],
                onExpansionChanged: (bool expanded) {
                  setState(() => _openCloseIcons[0] = expanded );
                  if (expanded == false) {
                    setState(() => _openCloseIcons[1] = false );
                    setState(() => _openCloseIcons[2] = false );
                  }
                },
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
