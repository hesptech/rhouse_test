import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_listing_mls.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/card_full_description_arguments.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_details_full/cards.dart';
import 'package:flutter_black_white/screens/game/game_screen.dart';
import 'package:flutter_black_white/screens/filters_results_screen.dart';
import 'package:flutter_black_white/screens/map_screen.dart';
import '../widgets/contact_agent_widget.dart';

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
          image: AssetImage('assets/logos/r_logo_112x38.png'),
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
              Navigator.pop(context);
            } else if (pathScreen == MapScreen.pathScreen) {
              Navigator.pop(context);
            }
             else {
              Navigator.pushNamed(context, '/');
            }
            
          },
          icon: const Icon(Icons.close_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon:  Icon(
               Platform.isAndroid ? Icons.share : CupertinoIcons.share,
              size: 30,
            ),
          ),
          const SizedBox( width: 10 ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_outlined,
              size: 30,
            ),
          ),
          const SizedBox( width: 10 )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                CardDetailsTop(listing),
                CardDetailsBox(listing),

                const SizedBox( height: 28 ), 

                CardDetailsHistory(
                  onInit: () => repliersHistory.initGetDisplay(),
                  onHistory: () => repliersHistory.getListingHistory(listing.mlsNumber),
                  listing: listing,
                ),

                const SizedBox( height: 28 ),

                CardDetailsMap(listing: listing),

                const SizedBox( height: 22.0 ),

                CardDetailsExpansions(listing),

                const SizedBox( height: 5 ),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text('Listing by')
                        ],
                      ),
                      Row(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Text(
                              listing.office?.brokerageName ?? '',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox( height: 90.0 ),
              ],
            ),
          ),

          // Floating footer button
          Positioned(
            bottom: 0,
            //left: 30,
            child: ContactAgentWidget(listing: listing),
          ),
        ],
      ),
    );
  }
}
