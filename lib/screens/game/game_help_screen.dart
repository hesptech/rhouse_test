import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_help_content.dart';

class GameHelpScreen extends StatelessWidget {
  static String pathScreen = "game_help_screen";

  const GameHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Container(
            height: 5.0,
            color: kSecondaryColor,
          )
        ),
        centerTitle: true,
        title: const Text('Help'),
      ),
      body: const SafeArea(
        child: GameHelpContent()
      )

    );
  }
}