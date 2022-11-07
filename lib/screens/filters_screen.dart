import 'package:flutter/material.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';

import 'package:flutter_black_white/filters/filters.dart';
import 'package:flutter_black_white/filters/filters_bathrooms.dart';
import 'package:flutter_black_white/filters/filters_bedrooms.dart';
import 'package:flutter_black_white/filters/filters_more.dart';



class FiltersScreen extends StatelessWidget {
  const FiltersScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Personalize Listing'),
      ),
      body: const FiltersExpansionTiles(),
      bottomNavigationBar: const FiltersBottomBar(),
    );
  }
}


class FiltersExpansionTiles extends StatefulWidget {
  const FiltersExpansionTiles({ Key? key }) : super(key: key);

  @override
  State<FiltersExpansionTiles> createState() => _FiltersExpansionTilesState();
}


class _FiltersExpansionTilesState extends State<FiltersExpansionTiles> {



  final isLoggedIn = Preferences.isLoggedIn;
  bool typeSelectAll = Preferences.userFilters.isNotEmpty;
  bool citySelectAll = Preferences.isLoggedIn ? Preferences.userFiltersCityIsLoggedIn.length == 4 : Preferences.userFiltersCity.length == 4 ;
  bool citySelectAllGtaNorth = true;

  //double _currentSliderValue = 0.0;
  var selectedRange = const RangeValues(500000, 2000000);


  @override
  void initState() {
    super.initState();




  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Container(
            height: 5,
            color: kSecondaryColor,
          ),
          const FiltersPriceRange(),
          const FiltersClassIconsBt(),
          const SizedBox( height: 28.0,),
          const GreenDivider(),
          const FiltersPropertyType(),
          const GreenDivider(),

          const FiltersLocation(),

          const GreenDivider(),

          const FiltersBedrooms(),

          const FiltersBathrooms(),

          const FiltersMore(),


          //Text('Prefs. notLoged? ${Preferences.userFilters}'),
          //Text('Prefs. notLoged city? ${Preferences.userFiltersCity}'),
          //Text('Prefs. notLoged city? ${Preferences.userFiltersCityGtaNorth}'),

          //Text('Prefs. log isLogged? ${Preferences.userFiltersIsLoggedIn}'),
          //Text('Prefs. log isLogged city? ${Preferences.userFiltersCityIsLoggedIn}'),
          //Text('Prefs. log isLogged city? ${Preferences.userFiltersCityGtaNorthLoggedIn}'),

          //Text('log isLogged? $isLoggedIn'),

    
        ],
      ),
    );
  }
}
