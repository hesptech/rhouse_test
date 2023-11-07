import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

class GameWelcomeScreen extends StatelessWidget {
  const GameWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Welcome Play&Learn'),
      ),
      body: const Center(
        child: Text('game welcome'),
      ),
    );
  }
}