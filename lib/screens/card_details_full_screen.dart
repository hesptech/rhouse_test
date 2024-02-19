import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_listing_mls.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/card_full_description_arguments.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_details_full/cards.dart';
import 'package:flutter_black_white/screens/game/game_screen.dart';
import 'package:flutter_black_white/screens/contact_agent_screen.dart';
import 'package:flutter_black_white/screens/filters_results_screen.dart';
import 'package:flutter_black_white/screens/map_screen.dart';

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
            bottom: 5,
            left: 30,
            child: listing.status == 'A' ? InkWell(
              onTap: () {
                Navigator.pushNamed(context, ContactAgentScreen.pathScreen, arguments: listing);
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 60,
                //padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, style: BorderStyle.solid, color: kPrimaryColor),
                ),
                child: const Align(alignment: Alignment.center, child: Text("CONTACT AGENT", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))),
              ),
            ) : const SizedBox( height: 0.0 ),
          ),

        ],
      ),
    );
  }
}
