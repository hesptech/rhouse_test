import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';

class CardVertical extends StatelessWidget {

  final Listing listing;

  const CardVertical( this.listing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const loggedIn = true;
    const blurImg = loggedIn == false ? 5.0 : 0.0;
    final screenSize = MediaQuery.of(context).size;

    return const Text('data');
  }
}
