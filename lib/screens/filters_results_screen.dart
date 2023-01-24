//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
//import 'package:flutter_black_white/providers/repliers_provider.dart';
import 'package:flutter_black_white/providers/repliers_filters.dart';
import 'package:flutter_black_white/widgets/widgets.dart';
import 'package:flutter_black_white/models/models.dart';

class FiltersResultsScreen extends StatefulWidget {
  const FiltersResultsScreen({Key? key}) : super(key: key);

  @override
  State<FiltersResultsScreen> createState() => _FiltersResultsScreenState();
}

class _FiltersResultsScreenState extends State<FiltersResultsScreen> {

  final Map<String, dynamic> filtersResults = {};
  late Map<String, dynamic> filtersPrefs;
  List<Listing> pippo = [];
  List<Listing> puppo = [];
  final labels = ['0', '100000', '150000', '200000', '250000', '300000', '350000', '400000', '450000', '500000', '550000', '600000', '650000', '700000', '750000', '800000', '850000', '900000', '950000', 
  '1000000', '1200000', '1300000', '1400000', '1500000', '1600000', '1700000', '1800000', '1900000', 
  '2000000', '2250000', '2500000', '2750000', '3000000', '3250000', '3500000', '3750000', '4000000', '4250000','4500000','4750000',
  '5000000'];
  late String filterPriceRangeStart;
  late String filterPriceRangeEnd;
  late String filtersBed;
  late String filtersParkings;
  late String filtersKitchens;

  @override
  void initState () {
    super.initState();
    filterPriceRangeStart = labels[Preferences.filterPriceRangeStart.round()].toString();
    filterPriceRangeEnd = labels[Preferences.filterPriceRangeEnd.round()].toString();
    if(Preferences.filtersClassIconsBt == 'residential'){
      filtersBed = Preferences.filtersBedHouse.toString();
      filtersParkings = Preferences.filtersNumParkingSpaces.toString();
      filtersKitchens = Preferences.filtersMinKitchens.toString();
    } else {
      filtersBed = Preferences.filtersBedCondo.toString();
      filtersParkings = Preferences.filtersNumParkingSpacesCondos >= 0 ? '1' : '1';
      filtersKitchens = '0';
    }
    Map<String, dynamic> filtersPrefs = {
        'pageNum': '1',
        'resultsPerPage': '15',
        'maxPrice': filterPriceRangeEnd,
        'minPrice': filterPriceRangeStart,
        'type': 'sale',
        'hasImages': 'true',
        'class': Preferences.filtersClassIconsBt,
        'minBeds': filtersBed,
        'minBaths': Preferences.filtersBath.toString(),
        'minParkingSpaces': filtersParkings,
        'minKitchens': filtersKitchens,
        //'city': 'toronto',
    };

    if(Preferences.filtersClassIconsBt == 'condo'){
      filtersPrefs['den'] = Preferences.filtersDen;
    }

    filtersResults.addAll(filtersPrefs);
    //ChangeNotifierProvider( create: (_) => RepliersFilters('toronto ALL'), lazy: false,);

  }


  /* @override
  void didChangeDependencies() {
    final repliersProvider = Provider.of<RepliersProvider>(context);
    repliersProvider.onDisplayFilters = [];
    repliersProvider.getDisplayFilters(filtersResults);         // OK
    super.didChangeDependencies();
  } */

  @override
  void dispose(){
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final repliersFilters = Provider.of<RepliersFilters>(context);
    //repliersFilters.onDisplayFilters = [];
    //repliersFilters.getDisplayFilters(filtersResults);
    //repliersProvider.onDisplayFilters = [];
    //repliersProvider.getDisplayFilters(filtersResults);
    //print(Preferences.filtersClassIconsBt);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Filters Results'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox( height: 4, ),


            CardsSliderFilters(
              listing: repliersFilters.onDisplayFilters,
              title: 'FILTERS Listings',
              //onNextPage: () => moviesProvider.getPopularMovies(),
              onNextPage: () => repliersFilters.getDisplayFilters(filtersResults),
              onInitPage: () => repliersFilters.initGetDisplay(filtersResults),
            ),
            //const SizedBox( height: 4, ),

            /* CardsSliderVertical(
              listing: repliersProvider.onDisplayHouses,
              title: 'HOUSE Listings',
              onNextPage: () => repliersProvider.getDisplayHouses(),
            ), */
          ],
        ),
      ),
    );

    /* return Provider<RepliersFilters>(
      create: (_) => RepliersFilters('toronto ALL'),
      builder: (context, child) {
        //final repliersFilters = Provider.of<RepliersFilters>(context);
        // No longer throws
        return SingleChildScrollView(
          child: Column(
            children: [
            CardsSliderFilters(
              listing: Provider.of<RepliersFilters>(context).onDisplayFilters,
              title: 'FILTERS Listings',
              //onNextPage: () => moviesProvider.getPopularMovies(),
              onNextPage: () => Provider.of<RepliersFilters>(context).getDisplayFilters(filtersResults),
            ),              
            ],
          ),
        );
      }
    ); */


    /* return ChangeNotifierProvider( 
      create: (_) { 
        RepliersFilters('toronto ALL');
        final repliersFilters = Provider.of<RepliersFilters>(context);
        pippo = repliersFilters.onDisplayFilters;
        puppo = repliersFilters.getDisplayFilters(filtersResults);
      }, 
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Filters Results'),
        ),  
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox( height: 4, ),


              CardsSliderFilters(
                listing: pippo,
                title: 'FILTERS Listings',
                //onNextPage: () => moviesProvider.getPopularMovies(),
                onNextPage: () => puppo,
              ),
              const SizedBox( height: 4, ),

              /* CardsSliderVertical(
                listing: repliersProvider.onDisplayHouses,
                title: 'HOUSE Listings',
                onNextPage: () => repliersProvider.getDisplayHouses(),
              ), */
            ],
          ),
        ),      
      ),
    ); */
  }
}
