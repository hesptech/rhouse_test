import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';

class FiltersBottomBar extends StatefulWidget {
  const FiltersBottomBar({Key? key}) : super(key: key);

  @override
  State<FiltersBottomBar> createState() => _FiltersBottomBarState();
}

class _FiltersBottomBarState extends State<FiltersBottomBar> {
  @override
  Widget build(BuildContext context) {

    final filterProvider = Provider.of<FilterProvider>( context );

    return Container(
            height: 75,
            color: kSecondaryColor,
            padding: const EdgeInsets.fromLTRB(22.0, 14.0, 22.0, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white), 
                        ),
                        onPressed: () {
                            setState(() {
                              Preferences.filterPriceRangeStart = 9.0;
                              Preferences.filterPriceRangeEnd = 28.0;
                              Preferences.filtersClassIconsBt = 'residential';
                              filterProvider.filterProvider = 'residential';
                              Preferences.filterPropertyIcons = [];
                              Preferences.filterPropertyIconsCondo = [];
                              Preferences.filterPropertyType = [];
                              Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse = [];

                              Preferences.filtersLocationTopbts = [];
                              Preferences.filtersTrCentral = [];
                              Preferences.filtersTrEast = [];
                              Preferences.filtersTrWest = [];
                              Preferences.filtersGtaWest = [];
                              Preferences.filtersGtaNorth = [];
                              Preferences.filtersGtaEast = [];
                              Preferences.filtersOther = []; 
                              Provider.of<FilterProvider>(context, listen: false).filtersLocation = []; 
                              
                              Preferences.filtersBedHouse = 1;
                              Preferences.filtersBedCondo = 0;
                              Preferences.filtersDen = 'N';
                              Preferences.filtersBath = 1;
                              Preferences.filtersNumParkingSpaces = 0;
                              Preferences.filtersNumParkingSpacesCondos = 0;
                              Preferences.filtersNumParkingSpacesCondos1 = false;
                              Preferences.filtersMinKitchens = 1;

                              Preferences.filtersStyleHouse = [];
                              Provider.of<FilterProvider>(context, listen: false).filtersStyleHouse = [];
                              Preferences.filtersStyleCondo = [];
                              Provider.of<FilterProvider>(context, listen: false).filtersStyleCondo = [];
                              Preferences.filtersBasement = [];
                              Provider.of<FilterProvider>(context, listen: false).filtersBasement = [];
                              Preferences.filtersAmmenities = [];
                              Provider.of<FilterProvider>(context, listen: false).filtersAmmenities = [];
                              Preferences.setfiltersMaxOpenHouseDate(false);
                              Preferences.setfiltersIndexSwimmingPool([]);

                              Preferences.filterDaysMarketStart = 0.0;
                              Preferences.filterDaysMarketEnd = 30.0;
                              Preferences.filterSizeStart = 10.0;
                              Preferences.filterSizeEnd = 3000.0;
                              Preferences.filterCondoFeeStart = 100.0;
                              Preferences.filterCondoFeeEnd = 1500.0;
                              Preferences.filtersCondoExtra = [];

                              Preferences.filtersPropertyTypeHouse = [];
                              Preferences.userFiltersCity = [];
                              Preferences.setfiltersIndexStyleHouse([]);
                              Preferences.setfiltersIndexStyleCondo([]);
                              Preferences.setfiltersIndexBasement([]);
                              Preferences.setfiltersIndexAmmenities([]);


                              Navigator.pushNamed(context, 'filters_screen');
                            });
                        },
                        child: const Text("CLEAR", style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    const SizedBox(width: 8.0,), 
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: kPrimaryColor), 
                          backgroundColor: kPrimaryColor
                        ),
                        onPressed: () {
                          Navigator.pushNamed( context, 'filters_results_screen', arguments: 'Filtered results' );
                        },
                        child: const Text("SUBMIT", style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
                      ),
                    ),                
                  ]
                ),
              ],
            ),     
    );
  }
}