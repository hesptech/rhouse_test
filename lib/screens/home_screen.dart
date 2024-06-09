import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_provider.dart';
import 'package:flutter_black_white/providers/repliers_favorites.dart';
import 'package:flutter_black_white/providers/repliers_game.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static String pathScreen = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final repliersProvider = Provider.of<RepliersProvider>(context);
    final filterProvider = Provider.of<FilterProvider>(context);
    final repliersStatusProperties = filterProvider.filtersStatusProperties;
    
    final repliersFavorites = Provider.of<RepliersFavorites>(context);
    final repliersGame = Provider.of<RepliersGame>(context);

      /* for (int i = 0; i < filterProvider.favoritesTemp.length; i++) {
        if(!repliersFavorites.onSelectFavorites.contains(filterProvider.favoritesTemp[i])) {
        print('second loop');
          filterProvider.favoritesTemp.removeWhere((element) => element == filterProvider.favoritesTemp[i]);
        }
      } */
    
    if (Preferences.userId > 0) {
    //if (Preferences.userId > 3) {
      if ( filterProvider.favoritesTemp.isEmpty) {
        repliersFavorites.getSelectFavorites(Preferences.userId.toString());
        for (int i = 0; i < repliersFavorites.onSelectFavorites.length; i++) { 
          if(!filterProvider.favoritesTemp.contains(repliersFavorites.onSelectFavorites[i])){
            //print(repliersFavorites.onSelectFavorites);
            filterProvider.favoritesTemp.add(repliersFavorites.onSelectFavorites[i]); 
          }   
        }      
        //filterProvider.favoritesTemp.add('0');
      }

      if ( filterProvider.gameTemp.isEmpty) {
        repliersGame.getSelectGame(Preferences.userId.toString());
        for (int i = 0; i < repliersGame.onSelectGame.length; i++) {
          if(!filterProvider.gameTemp.contains(repliersGame.onSelectGame[i])){
            //print(repliersGame.onSelectGame[i]);
            filterProvider.gameTemp.add(repliersGame.onSelectGame[i]);
          }
        }
        filterProvider.gameTempObj.addAll(repliersGame.onSelectGameObj);
      }
    }

    //onSelectGameObj

    return Scaffold(
      appBar: const CustomAppbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox( height: 45,),

                CardsSliderHor(
                  listing: repliersProvider.onDisplayHouses,
                  title: 'HOUSE Listings',
                  onNextPage: () => repliersProvider.getDisplayHouses(repliersStatusProperties),
                  onInitPage: () => repliersProvider.initGetDisplay(repliersStatusProperties),
                ),

                CardsSliderHor(
                  listing: repliersProvider.onDisplayCondo,
                  title: 'CONDO Listings',
                  onNextPage: () => repliersProvider.getDisplayCondo(repliersStatusProperties),
                  onInitPage: () => repliersProvider.initGetDisplay(repliersStatusProperties),
                ),

              ],
            ),
          ),
          const FiltersStatusBt(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigator(),
    );    
  }
}
