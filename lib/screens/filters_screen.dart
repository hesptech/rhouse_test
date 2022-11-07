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

  late List<PropertiesRooms> _propertiesRooms;
  late List<PropertiesBaths> _propertiesBaths;
  late List<String> _filtersSearch;
  late List<String> _filtersSearchIsLoggedIn;
  late List<String> _filtersSearchCity;
  late List<String> _filtersSearchCityIsLoggedIn;

  final isLoggedIn = Preferences.isLoggedIn;
  bool typeSelectAll = Preferences.userFilters.isNotEmpty;
  bool citySelectAll = Preferences.isLoggedIn ? Preferences.userFiltersCityIsLoggedIn.length == 4 : Preferences.userFiltersCity.length == 4 ;
  bool citySelectAllGtaNorth = true;

  //double _currentSliderValue = 0.0;
  var selectedRange = const RangeValues(500000, 2000000);


  @override
  void initState() {
    super.initState();

    _propertiesRooms = <PropertiesRooms>[
      const PropertiesRooms('0+'),
      const PropertiesRooms('1+'),
      const PropertiesRooms('2+'),
      const PropertiesRooms('3+'),
      const PropertiesRooms('4+'),
      const PropertiesRooms('5+'),
      const PropertiesRooms('6+'),
    ];
    _propertiesBaths = <PropertiesBaths>[
      const PropertiesBaths('0+'),
      const PropertiesBaths('1+'),
      const PropertiesBaths('2+'),
      const PropertiesBaths('3+'),
      const PropertiesBaths('4+'),
      const PropertiesBaths('5+'),
      const PropertiesBaths('6+'),
    ];
    _filtersSearch = Preferences.userFilters;
    _filtersSearchIsLoggedIn = Preferences.userFiltersIsLoggedIn;
    _filtersSearchCity = Preferences.userFiltersCity;
    _filtersSearchCityIsLoggedIn = Preferences.userFiltersCityIsLoggedIn;

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

          const FiltersPropertyType(),

          //const SizedBox( height: 14.0, ),

          const FiltersLocation(),

          const GreenDivider(),

          const FiltersBedrooms(),

          const FiltersBathrooms(),

          const FiltersMore(),
          //Text('Selected notLogged: ${_filtersSearch.join(', ')}'),
          //Text('Selected notLogged city: ${_filtersSearchCity.join(', ')}'),


          //Text('Selected isLogged: ${_filtersSearchIsLoggedIn.join(', ')}'),
          //Text('Selected isLogged city: ${_filtersSearchCityIsLoggedIn.join(', ')}'),



          //Text('Prefs. notLoged? ${Preferences.userFilters}'),
          //Text('Prefs. notLoged city? ${Preferences.userFiltersCity}'),
          //Text('Prefs. notLoged city? ${Preferences.userFiltersCityGtaNorth}'),

          //Text('Prefs. log isLogged? ${Preferences.userFiltersIsLoggedIn}'),
          //Text('Prefs. log isLogged city? ${Preferences.userFiltersCityIsLoggedIn}'),
          //Text('Prefs. log isLogged city? ${Preferences.userFiltersCityGtaNorthLoggedIn}'),

          //Text('log isLogged? $isLoggedIn'),
          //Text('type lenght? ${_filtersSearch.length}'),
    
        ],
      ),
    );
  }




  Iterable<Widget> get propertiesRoomsWidgets sync* {
    for (PropertiesRooms propertiesRooms in _propertiesRooms) {
      print('in ROOMS');
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 2.0 ),
        child: ChoiceChip(
          label: Container(
            width: 32,
            alignment: Alignment.center,
            child: Text(propertiesRooms.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kSecondaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersSearch.contains(propertiesRooms.name),
          onSelected: ( bool selected ) {
            setState(() {
              if(selected){
                _filtersSearch.add(propertiesRooms.name);
              }else{
                _filtersSearch.removeWhere((String name) => name == propertiesRooms.name);
              }
            });
          },
        )
      );
    }
  }

  Iterable<Widget> get propertiesBathsWidgets sync* {
    for (PropertiesBaths propertiesBaths in _propertiesBaths) {
      yield Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: ChoiceChip(
          label: Container(
            width: 32,
            alignment: Alignment.center,
            child: Text(propertiesBaths.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor),),
          ), 
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kSecondaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersSearch.contains(propertiesBaths.name),
          onSelected: ( bool selected ) {
            setState(() {
              if (selected) {
                _filtersSearch.add(propertiesBaths.name);
              } else {
                _filtersSearch.removeWhere(( String name ) => name == propertiesBaths.name);
              }
            });
          },
        ),
      );
    }
  }
}


class PropertiesRooms {
  const PropertiesRooms(this.name);
  final String name;
}

class PropertiesBaths {
  const PropertiesBaths(this.name);
  final String name;
}
