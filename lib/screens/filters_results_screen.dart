//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/providers/repliers_provider.dart';
import 'package:flutter_black_white/widgets/widgets.dart';

class FiltersResultsScreen extends StatefulWidget {
  const FiltersResultsScreen({Key? key}) : super(key: key);

  @override
  State<FiltersResultsScreen> createState() => _FiltersResultsScreenState();
}

class _FiltersResultsScreenState extends State<FiltersResultsScreen> {

  late String _filtersClassIconsBt;

  @override
  void initState () {
    super.initState();

    _filtersClassIconsBt = Preferences.filtersClassIconsBt;
  }

  @override
  Widget build(BuildContext context) {

    final repliersProvider = Provider.of<RepliersProvider>(context);
    print(_filtersClassIconsBt);

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
              listing: repliersProvider.onDisplayCondo,
              title: 'FILTERS Listings',
              //onNextPage: () => moviesProvider.getPopularMovies(),
              onNextPage: () => repliersProvider.getDisplayFilters(),
            ),
            const SizedBox( height: 4, ),

            CardsSliderVertical(
              listing: repliersProvider.onDisplayHouses,
              title: 'HOUSE Listings',
              onNextPage: () => repliersProvider.getDisplayHouses(),
            ),
          ],
        ),
      ),
    );
  }
}
