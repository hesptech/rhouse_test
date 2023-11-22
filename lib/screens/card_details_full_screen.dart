import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_black_white/utils/search_delegate.dart';

import 'package:flutter_black_white/providers/repliers_listing_mls.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/card_full_description_arguments.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_details_full/cards.dart';
import 'package:flutter_black_white/screens/game/game_screen.dart';
import 'package:flutter_black_white/screens/filters_results_screen.dart';
//import 'package:flutter_black_white/screens/home_screen.dart';

class CardDetailsFullScreen extends StatelessWidget {
  const CardDetailsFullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Listing listing = ModalRoute.of(context)?.settings.arguments! as Listing;
    final CardFullDescriptionArguments screenArguments = ModalRoute.of(context)?.settings.arguments! as CardFullDescriptionArguments;
    final Listing listing = screenArguments.listing;
    final String pathScreen = screenArguments.pathScreen;
    final repliersHistory = Provider.of<RepliersListingMls>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Container(
            height: 5.0,
            color: kSecondaryColor,
          )
        ),
        elevation: 0,
        centerTitle: true,
        title: const Image(
          image: AssetImage('assets/r_logo_112x38.png'),
        ),
        leading: IconButton(
          onPressed: () {
            if (pathScreen == FiltersResultsScreen.pathScreen) {
              Navigator.pushNamed(context, 'filters_results_screen');
            } else if (pathScreen == GameScreen.pathScreen) {
              Navigator.pushNamed(context, 'game_screen');
            } else if (pathScreen == 'favorites_screen') {
               Navigator.pushNamed(context, 'favorites_screen');
            } else if (pathScreen == 'card_game_banner') {
               Navigator.pop(context);
            } else if (pathScreen == 'search') {
              //showSearch(context: context, delegate: InputSearchDelegate());
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, '/');
            }
          },
          icon: const Icon(Icons.close_outlined),
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
            CardDetailsTop(listing),
            CardDetailsBox(listing),
            const SizedBox(
              height: 14,
            ),           
            const SizedBox(
              height: 14,
            ),
            CardDetailsHistory(
              onInit: () => repliersHistory.initGetDisplay(),
              onHistory: () => repliersHistory.getListingHistory(listing.mlsNumber),
              listing: listing,
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
