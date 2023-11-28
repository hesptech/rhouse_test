import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_favorites.dart';
import 'package:flutter_black_white/providers/repliers_provider.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static String pathScreen = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final repliersProvider = Provider.of<RepliersProvider>(context);
    
    final filterProvider = Provider.of<FilterProvider>(context);
    final repliersStatusProperties = filterProvider.filtersStatusProperties;
    
    final repliersFavorites = Provider.of<RepliersFavorites>(context, listen: false);
    repliersFavorites.getSelectFavorites('2');

      for (int i = 0; i < repliersFavorites.onSelectFavorites.length; i++) { 
        if(!filterProvider.gameFavoritesTemp.contains(repliersFavorites.onSelectFavorites[i])){
          filterProvider.gameFavoritesTemp.add(repliersFavorites.onSelectFavorites[i]); 
        }   
      }
      print(filterProvider.gameFavoritesTemp);


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
