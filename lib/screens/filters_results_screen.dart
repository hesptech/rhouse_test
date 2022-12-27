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

  @override
  void initState () {
    super.initState();

    Map<String, dynamic> filtersPrefs = {
        'pageNum': '1',
        'resultsPerPage': '15',
        'maxPrice': '2000000',
        'minPrice': '1500000',
        'type': 'sale',
        'hasImages': 'true',
        'class': Preferences.filtersClassIconsBt,
    };
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
