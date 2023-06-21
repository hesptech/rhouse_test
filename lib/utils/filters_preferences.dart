import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersPreferences  {

    final Map<String, dynamic> filtersResults = {};
    late Map<String, dynamic> filtersPrefs = {};
    final labels = kLabels;
    late List<String> filterPropertyIcons;
    DateTime todayDate = DateTime.now();
    List filtersPropertyTypeHouse = [];

    FiltersPreferences(filtersPropertyTypeHouse);


    setFilterPreferences(){
      filtersPrefs['class'] = Preferences.filtersClassIconsBt;

      if(Preferences.filtersClassIconsBt == 'residential'){
        filterPropertyIcons = [...Preferences.filterPropertyIcons, ...filtersPropertyTypeHouse];
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
        if(Preferences.getfiltersIndexStyleHouse().isNotEmpty) filtersPrefs['style'] = Preferences.getfiltersIndexStyleHouse();
        if(Preferences.getfiltersIndexBasement().isNotEmpty) filtersPrefs['basement'] = Preferences.getfiltersIndexBasement();
      } else {
        if(Preferences.getfiltersIndexStyleCondo().isNotEmpty) filtersPrefs['style'] = Preferences.getfiltersIndexStyleCondo();
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
      }     
    }


    setFilterQueryParams() {
      setFilterPreferences();
      filtersResults.addAll(filtersPrefs);
      return filtersResults;
    }
}