import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_provider.dart';
import 'package:flutter_black_white/filters/filters.dart';
import 'package:flutter_black_white/widgets/widgets.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final repliersProvider = Provider.of<RepliersProvider>(context);

    return Scaffold(
      appBar: const CustomAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox( height: 15,),
            const FiltersClassButtons(),
            //Text(Preferences.locationLat.toString()),
            //Text(Preferences.locationLng.toString()),


            CardsSliderHor(
              listing: repliersProvider.onDisplayHouses,
              title: 'HOUSE Listing',
              //onNextPage: () => moviesProvider.getPopularMovies(),
              onNextPage: () => repliersProvider.getDisplayHouses(),
            ),

            CardsSliderHor(
              listing: repliersProvider.onDisplayCondo,
              title: 'CONDO Listing',
              //onNextPage: () => moviesProvider.getPopularMovies(),
              onNextPage: () => repliersProvider.getDisplayCondo(),
            ),

          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigator(),
    );    
  }
}