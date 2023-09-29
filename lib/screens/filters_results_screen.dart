import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/providers/repliers_filters.dart';
import 'package:flutter_black_white/utils/filters_preferences.dart';
import 'package:flutter_black_white/widgets/widgets.dart';


class FiltersResultsScreen extends StatefulWidget {
  const FiltersResultsScreen({Key? key}) : super(key: key);

  @override
  State<FiltersResultsScreen> createState() => _FiltersResultsScreenState();
}

class _FiltersResultsScreenState extends State<FiltersResultsScreen> {

  final Map<String, dynamic> filtersResults = {};
  late Map<String, dynamic> filtersPrefs;
  final labels = kLabels;
  late String filterPriceRangeStart;
  late String filterPriceRangeEnd;
  late List<String> filterPropertyIcons;
  DateTime todayDate = DateTime.now();

  @override
  void initState () {
    super.initState();

    Map<String, dynamic> filtersPrefs = {
        'resultsPerPage': '15',
        'type': 'sale',
        'hasImages': 'true',
        'district': Provider.of<FilterProvider>(context, listen: false).filtersLocation,
    };

    filtersPrefs.addAll(FiltersPreferences(Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse).setFilterQueryParams());

    filtersResults.addAll(filtersPrefs);
  }


  @override
  void dispose(){
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final repliersFilters = Provider.of<RepliersFilters>(context);
    //print(repliersFilters.onCount);

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Container(
            height: 5.0,
            color: kSecondaryColor,
          )
        ),
        centerTitle: true,
        title: const Text('Filters Results'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox( height: 4, ),
            CardsSliderFilters(
              listing: repliersFilters.onDisplayFilters,
              //loaded: repliersFilters.loaded,
              //countListings: repliersFilters.onCount,
              onNextPage: () => repliersFilters.getDisplayFilters(filtersResults),
              onInitPage: () => repliersFilters.initGetDisplay(filtersResults),
            ),
          ],
        ),
      ),
    );
  }
}
