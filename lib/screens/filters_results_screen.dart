import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/filters_preferences.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/providers/repliers_filters.dart';
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

    /* if(Preferences.filtersClassIconsBt == 'residential'){
      filterPropertyIcons = [...Preferences.filterPropertyIcons, ...Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse];
    } else {
      filterPropertyIcons = Preferences.filterPropertyIconsCondo;
    } */

    //print(filterPropertyIcons);

    Map<String, dynamic> filtersPrefs = {
        'pageNum': '1',
        'resultsPerPage': '15',
        'type': 'sale',
        'hasImages': 'true',
        //'class': Preferences.filtersClassIconsBt,
        //'propertyType': filterPropertyIcons,
        'district': Provider.of<FilterProvider>(context, listen: false).filtersLocation,
    };


    /* filtersPrefs['class'] = Preferences.filtersClassIconsBt;

    if(Preferences.filtersClassIconsBt == 'residential'){
      filterPropertyIcons = [...Preferences.filterPropertyIcons, ...Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse];
      filtersPrefs['propertyType'] = filterPropertyIcons;
    } else {
      filterPropertyIcons = Preferences.filterPropertyIconsCondo;
      filtersPrefs['propertyType'] = filterPropertyIcons;
    }


    if(int.parse(labels[Preferences.filterPriceRangeStart.round()]) > 1 ) {
      filtersPrefs['minPrice'] = labels[Preferences.filterPriceRangeStart.round()].toString();
    } 

    if(int.parse((labels[Preferences.filterPriceRangeEnd.round()])) <= 4750000 ) {
      filtersPrefs['maxPrice'] = labels[Preferences.filterPriceRangeEnd.round()].toString();
    }

    if(Preferences.filtersClassIconsBt == 'residential' && Preferences.filtersBedHouse > 1){
      filtersPrefs['minBeds'] = Preferences.filtersBedHouse.toString();
    } else if(Preferences.filtersClassIconsBt == 'condo' && Preferences.filtersBedCondo > 0){
      filtersPrefs['minBeds'] = Preferences.filtersBedCondo.toString();
    }

    if(Preferences.filtersBath > 1){
      filtersPrefs['minBaths'] = Preferences.filtersBath.toString();
    } 

    if(Preferences.filtersClassIconsBt == 'residential' && Preferences.filtersNumParkingSpaces > 0){
      filtersPrefs['minParkingSpaces'] = Preferences.filtersNumParkingSpaces.toString();
    } else if(Preferences.filtersClassIconsBt == 'condo' && Preferences.filtersNumParkingSpacesCondos1 == true){
      filtersPrefs['minParkingSpaces'] = '1';
    }

    if(Preferences.filtersClassIconsBt == 'residential' && Preferences.filtersMinKitchens > 1){
      filtersPrefs['minKitchens'] = Preferences.filtersMinKitchens.toString();
    }

    DateTime maxListDate = todayDate.subtract(Duration(days: Preferences.filterDaysMarketStart.toInt()));
    filtersPrefs['maxListDate'] = maxListDate.toString().substring(0, 10);    

    if(Preferences.filterDaysMarketEnd < 90){
      DateTime minListDate = todayDate.subtract(Duration(days: Preferences.filterDaysMarketEnd.toInt()));
      filtersPrefs['minListDate'] = minListDate.toString().substring(0, 10);
      //filtersPrefs['maxListDate'] = maxListDate.toString().substring(0, 10);
    }

    if(Preferences.filtersClassIconsBt == 'condo' && Preferences.filtersDen == 'Y'){
      filtersPrefs['den'] = Preferences.filtersDen;
    }

    if(Preferences.filtersClassIconsBt == 'residential') {
      filtersPrefs['style'] = Preferences.getfiltersIndexStyleHouse();
      filtersPrefs['basement'] = Preferences.getfiltersIndexBasement();
    } else {
      filtersPrefs['style'] = Preferences.getfiltersIndexStyleCondo();
    }

    if(Preferences.filtersClassIconsBt == 'residential' && Preferences.getfiltersMaxOpenHouseDate() == true) {
      filtersPrefs['minOpenHouseDate'] = todayDate.toString().substring(0, 10);
    }

    if(Preferences.filtersClassIconsBt == 'residential' && Preferences.getfiltersIndexSwimmingPool().isNotEmpty) {
      filtersPrefs['swimmingPool'] = Preferences.getfiltersIndexSwimmingPool();
    }

    if(Preferences.filtersClassIconsBt == 'condo' && Preferences.filterSizeStart > 10 ) {
      filtersPrefs['minSqft'] = Preferences.filterSizeStart.round().toString();
    } 

    if(Preferences.filtersClassIconsBt == 'condo' && Preferences.filterSizeEnd < 2999 ) {
      filtersPrefs['maxSqft'] = Preferences.filterSizeEnd.round().toString();
    }    

    
    if(Preferences.filtersClassIconsBt == 'condo' && Preferences.filterCondoFeeEnd < 1500 ) {
      filtersPrefs['maxMaintenanceFee'] = Preferences.filterCondoFeeEnd.round().toString();
    }

    if(Preferences.filtersClassIconsBt == 'condo') {
      filtersPrefs['amenities'] = Preferences.getfiltersIndexAmmenities();
    }  */


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
        centerTitle: true,
        title: const Text('Filters Results'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox( height: 4, ),
            CardsSliderFilters(
              listing: repliersFilters.onDisplayFilters,
              loaded: repliersFilters.loaded,
              countListings: repliersFilters.onCount,
              onNextPage: () => repliersFilters.getDisplayFilters(filtersResults),
              onInitPage: () => repliersFilters.initGetDisplay(filtersResults),
            ),
          ],
        ),
      ),
    );
  }
}
