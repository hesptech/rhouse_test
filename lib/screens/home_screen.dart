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
    
    final repliersFavorites = Provider.of<RepliersFavorites>(context);

      /* for (int i = 0; i < filterProvider.favoritesTemp.length; i++) {
        if(!repliersFavorites.onSelectFavorites.contains(filterProvider.favoritesTemp[i])) {
        print('second loop');
          filterProvider.favoritesTemp.removeWhere((element) => element == filterProvider.favoritesTemp[i]);
        }
      } */

    if ( filterProvider.favoritesTemp.isEmpty) {
      repliersFavorites.getSelectFavorites('2');
      for (int i = 0; i < repliersFavorites.onSelectFavorites.length; i++) { 
        if(!filterProvider.favoritesTemp.contains(repliersFavorites.onSelectFavorites[i])){
          filterProvider.favoritesTemp.add(repliersFavorites.onSelectFavorites[i]); 
        }   
      }      
      //filterProvider.favoritesTemp.add('0');
    }

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
