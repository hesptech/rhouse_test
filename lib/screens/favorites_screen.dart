import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_favorites.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
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
          children: Preferences.isLoggedIn 
          ? [
              CardsSliderFavorites(
                listing: repliersFavorites.onDisplayFavorites,
                onInitPage: () => repliersFavorites.initGetDisplay(filterProvider.gameFavoritesTemp),
              ),           
            ]
          : [
              const SizedBox(height: 23.0,),
              const Icon(Icons.favorite, color: kSecondaryColor, size: 42),
              const Center(
                heightFactor: 3.0,
                child: Text(
                  'Create an account \n or sign into your existing account \n to save FAVORITES Listings.',  
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 99, 99, 99),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size(320, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: kSecondaryColor,
                ),
                child: const Text(
                  "LOG IN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'login_screen');
                },
              ),
              const SizedBox(height: 40.0),
              const Text(
                "New user?",
                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'register_screen');
                },
                child: const Text(
                  "Sign up here",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: kPrimaryColor,
                  ),
                ),
              )       
            ],
        ),
      ),
    );
  }
}