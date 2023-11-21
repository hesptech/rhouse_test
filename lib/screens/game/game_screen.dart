import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/providers/repliers_game.dart';
import 'package:flutter_black_white/widgets/cards_slider_game.dart';
import 'package:flutter_black_white/models/models.dart';


class GameScreen extends StatelessWidget {
  static String pathScreen = "game_screen";

  final Listing? bannerPriceListing;
  const GameScreen({super.key, this.bannerPriceListing});

  @override
  Widget build(BuildContext context) {

    Listing listingArgument = _checkArguments(context);
    List valuesParams = ['n7274034','w7275236','w7235370','N5632323'];
    final repliersGame = Provider.of<RepliersGame>(context);

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).clearMaterialBanners();
        return true;
      },      
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(5.0),
            child: Container(
              height: 5.0,
              color: kSecondaryColor,
            )
          ),
          centerTitle: true,
          title: const Image(
            image: AssetImage('assets/play&learn_logo108x37.png'),
          ),
          leading: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(Icons.close_outlined),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                Navigator.pushNamed(context, 'game_welcome_screen');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                      Icons.help_center_outlined, size: 24.0, 
                  ),
                  SizedBox(width: 3.0,),
                  Text(
                    'Help',
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(width: 15.0,),
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardsSliderGame(
                listing: repliersGame.onDisplayGame,
                //listing: repliersGame.getDisplayGame(valuesParams),
                onInitPage: () => repliersGame.initGetDisplay(valuesParams),
                bannerPriceListing: listingArgument,
              ),
            ],
          ),
        ),
        /* body: const Center(
          child: Text('game screen'),
        ), */
      ),
    );
  }

  Listing _checkArguments(BuildContext context) {
    try {
      final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

      return arguments["listing"] as Listing;
    } catch (e) {
      //Navigator.pop(context);
      return Listing();
    }
  }
}