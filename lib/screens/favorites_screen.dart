import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_favorites.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/widgets/cards_slider_favorites.dart';

class FavoritesScreen extends StatelessWidget {
  static String pathScreen = "favorites_screen";

  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final repliersFavorites = Provider.of<RepliersFavorites>(context);
    final filterProvider = Provider.of<FilterProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          icon: const Icon(Icons.close_outlined),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Container(
            height: 5.0,
            color: kSecondaryColor,
          )
        ),
        centerTitle: true,
        title: const Text('Favorites'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            CardsSliderFavorites(
              listing: repliersFavorites.onDisplayFavorites,
              onInitPage: () => repliersFavorites.initGetDisplay(filterProvider.gameFavoritesTemp),
            ),
          ],
        ),
      ),
    );
  }
}