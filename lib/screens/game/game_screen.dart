import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/providers/repliers_game.dart';
import 'package:flutter_black_white/widgets/cards_slider_game.dart';


class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List valuesParams = ['n7274034','w7275236','w7235370'];
    final repliersGame = Provider.of<RepliersGame>(context);

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Container(
            height: 5.0,
            color: kSecondaryColor,
          )
        ),
        centerTitle: true,
        title: const Text('Play&Learn'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardsSliderGame(
              listing: repliersGame.onDisplayGame,
              //listing: repliersGame.getDisplayGame(valuesParams),
              onInitPage: () => repliersGame.initGetDisplay(valuesParams),
            ),
          ],
        ),
      ),
      /* body: const Center(
        child: Text('game screen'),
      ), */
    );
  }
}