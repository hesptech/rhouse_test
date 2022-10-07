import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter/material.dart';


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
    );
  }
}


class FiltersExpansionTiles extends StatefulWidget {
  const FiltersExpansionTiles({ Key? key }) : super(key: key);

  @override
  State<FiltersExpansionTiles> createState() => _FiltersExpansionTilesState();
}


class _FiltersExpansionTilesState extends State<FiltersExpansionTiles> {

  late List<PropertiesCityGtaCentral> _propertiesCityGtaCentral;
  late List<PropertiesCityGtaNorth> _propertiesCityGtaNorth;
  late List<PropertiesTypes> _propertiesTypes;
  late List<PropertiesRooms> _propertiesRooms;
  late List<PropertiesBaths> _propertiesBaths;
  late List<String> _filtersSearch;
  late List<String> _filtersSearchIsLoggedIn;
  late List<String> _filtersSearchCity;
  late List<String> _filtersSearchCityIsLoggedIn;
  late List<String> _filtersSearchCityGtaNorth;
  late List<String> _filtersSearchCityGtaNorthLoggedIn;

  final isLoggedIn = Preferences.isLoggedIn;
  bool typeSelectAll = Preferences.userFilters.isNotEmpty;
  bool citySelectAll = Preferences.isLoggedIn ? Preferences.userFiltersCityIsLoggedIn.length == 4 : Preferences.userFiltersCity.length == 4 ;
  bool citySelectAllGtaNorth = true;


  //double _currentSliderValue = 0.0;
  var selectedRange = const RangeValues(500000, 2000000);


  @override
  void initState() {
    super.initState();
    _propertiesCityGtaCentral = <PropertiesCityGtaCentral>[
      const PropertiesCityGtaCentral('Toronto'),
      const PropertiesCityGtaCentral('North York'),
      const PropertiesCityGtaCentral('Scarborough'),
      const PropertiesCityGtaCentral('Etobicoke'),
    ];
    _propertiesCityGtaNorth = <PropertiesCityGtaNorth>[
      const PropertiesCityGtaNorth('Markham'),
      const PropertiesCityGtaNorth('Richmond Hill'),
      const PropertiesCityGtaNorth('Vaughan'),
      const PropertiesCityGtaNorth('Whithchurh-Stouffville'),
      const PropertiesCityGtaNorth('Aurora'),
      const PropertiesCityGtaNorth('Newmarket'),
      const PropertiesCityGtaNorth('King'),
      const PropertiesCityGtaNorth('Giorgina'),
    ];
    _propertiesTypes = <PropertiesTypes>[
      const PropertiesTypes('Detached'),
      const PropertiesTypes('Semi-Detached'),
      const PropertiesTypes('Free-hold Townhouse'),
      const PropertiesTypes('Condo Townhouse'),
      const PropertiesTypes('Condo Apt'),
    ];
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
    _filtersSearchCityGtaNorth = Preferences.userFiltersCityGtaNorth;
    _filtersSearchCityGtaNorthLoggedIn = Preferences.userFiltersCityGtaNorthLoggedIn;
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



          // RANGE-SLIDER
          Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 28.0),
            child: Column(
              children: [
                const Text('Price Range', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: kSecondaryColor),),
                const SizedBox(height: 14.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or less', 
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, ),
                    ),
                    Text(
                      '\$${selectedRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more', 
                      textAlign: TextAlign.right, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, ),
                    ),
                  ],
                ),
                SliderTheme(
                  data: const SliderThemeData(
                    thumbColor: kSecondaryColor,
                    activeTrackColor: kPrimaryColor,
                    inactiveTrackColor: kSecondaryColor,
                  ), 
                  child: RangeSlider(
                    min: 0,
                    max: 5000000,
                    labels: RangeLabels('${selectedRange.start}', '${selectedRange.end}'),
                    values: selectedRange,
                    onChanged: (RangeValues newRange) {
                      setState(() => selectedRange = newRange);
                    },
                  ),
                ),
              ],
            ),
          ),



          // TYPES
          const Text(
            'Property Type', 
            style: TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.w500, 
              color: kSecondaryColor
            ),
          ),
          /* Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 14.0, 28.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text('Types', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLoggedIn ? _filtersSearchIsLoggedIn.clear() : _filtersSearch.clear();
                      if(typeSelectAll) {
                        typeSelectAll = false;
                      } else {
                        typeSelectAll = true;
                        for (var element in _propertiesTypes) {
                         isLoggedIn ? _filtersSearchIsLoggedIn.add(element.name) : _filtersSearch.add(element.name) ;
                        } 
                      } 
                      isLoggedIn ? Preferences.userFiltersIsLoggedIn = _filtersSearchIsLoggedIn :  Preferences.userFilters = _filtersSearch ;                      
                    });
                  },
                  child: Text( typeSelectAll ? 'Unselect all' : 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
                )
              ],
            ),
          ), */
          const SizedBox( height: 14.0, ),
          Wrap(
            children: propertiesTypesWidgets.toList(),
          ),




          const SizedBox( height: 32.0, ),




          // City
          const Text(
            'City', 
            style: TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.w500, 
              color: kSecondaryColor
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 4.0, 28.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text('GTA - Central', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLoggedIn ? _filtersSearchCityIsLoggedIn.clear() : _filtersSearchCity.clear();
                      if(citySelectAll) {
                        citySelectAll = false;
                      } else {
                        citySelectAll = true;
                        for (var element in _propertiesCityGtaCentral) {
                          isLoggedIn ? _filtersSearchCityIsLoggedIn.add(element.name) : _filtersSearchCity.add(element.name) ;
                        } 
                      }
                      isLoggedIn ? Preferences.userFiltersCityIsLoggedIn = _filtersSearchCityIsLoggedIn : Preferences.userFiltersCity = _filtersSearchCity ;                      
                    });
                  },
                  child: Text( citySelectAll ? 'Unselect all' : 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
                )
              ],
            ),
          ),
          Wrap(
            children: propertiesCityGtaCentralWidgets.toList(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 4.0, 28.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('GTA - North', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLoggedIn ? _filtersSearchCityGtaNorthLoggedIn.clear() : _filtersSearchCityGtaNorth.clear() ;
                      if(citySelectAllGtaNorth) {
                        citySelectAllGtaNorth = false;
                      } else {
                        citySelectAllGtaNorth = true;
                        for (var element in _propertiesCityGtaNorth) {
                          isLoggedIn ? _filtersSearchCityGtaNorthLoggedIn.add(element.name) : _filtersSearchCityGtaNorth.add(element.name) ;
                        }
                      }
                      isLoggedIn ? Preferences.userFiltersCityGtaNorthLoggedIn = _filtersSearchCityGtaNorthLoggedIn : Preferences.userFiltersCityGtaNorth = _filtersSearchCityGtaNorth ;
                    });  
                  }, 
                  child: Text(citySelectAllGtaNorth ? 'Unselect all' : 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
                )
              ],
            ),
          ),
          Wrap(
            children: propertiesCityGtaNorthWidgets.toList(),
          ),



          const SizedBox( height: 32.0, ),



          // TYPES
          const Text(
            'More Filters', 
            style: TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.w500, 
              color: kSecondaryColor
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 8.0, 28.0, 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Beds', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),),
              ],
            ),
          ),
          Wrap(
            children: propertiesRoomsWidgets.toList(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 14.0, 28.0, 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Baths', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),),
              ],
            ),
          ),
          Wrap(
            children: propertiesBathsWidgets.toList(),
          ),














          //Text('Selected notLogged: ${_filtersSearch.join(', ')}'),
          //Text('Selected notLogged city: ${_filtersSearchCity.join(', ')}'),
          Text('Selected notLogged city: ${_filtersSearchCityGtaNorth.join(', ')}'),

          //Text('Selected isLogged: ${_filtersSearchIsLoggedIn.join(', ')}'),
          //Text('Selected isLogged city: ${_filtersSearchCityIsLoggedIn.join(', ')}'),
          Text('Selected isLogged city: ${_filtersSearchCityGtaNorthLoggedIn.join(', ')}'),


          //Text('Prefs. notLoged? ${Preferences.userFilters}'),
          //Text('Prefs. notLoged city? ${Preferences.userFiltersCity}'),
          Text('Prefs. notLoged city? ${Preferences.userFiltersCityGtaNorth}'),

          //Text('Prefs. log isLogged? ${Preferences.userFiltersIsLoggedIn}'),
          //Text('Prefs. log isLogged city? ${Preferences.userFiltersCityIsLoggedIn}'),
          Text('Prefs. log isLogged city? ${Preferences.userFiltersCityGtaNorthLoggedIn}'),

          Text('log isLogged? $isLoggedIn'),
          //Text('type lenght? ${_filtersSearch.length}'),
    
        ],
      ),
    );
  }








  Iterable<Widget> get propertiesTypesWidgets sync* {
    for (PropertiesTypes propertiesTypes in _propertiesTypes) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 6.0 ),
        child: ChoiceChip(
          label: Container(
            width: 140,
            alignment: Alignment.center,
            child: Text(propertiesTypes.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor),),
          ),
          backgroundColor: Colors.transparent,
          selectedColor: const Color(0xFF0BB48B),
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: isLoggedIn ? _filtersSearchIsLoggedIn.contains(propertiesTypes.name) : _filtersSearch.contains(propertiesTypes.name),
          onSelected: ( bool selected ) {
            setState(() {
              if(isLoggedIn){
                selected ? _filtersSearchIsLoggedIn.add(propertiesTypes.name) : _filtersSearchIsLoggedIn.removeWhere((String name) => name == propertiesTypes.name) ;
                Preferences.userFiltersIsLoggedIn = _filtersSearchIsLoggedIn;                
              }else{
                selected ? _filtersSearch.add(propertiesTypes.name) : _filtersSearch.removeWhere((String name) => name == propertiesTypes.name) ;
                Preferences.userFilters = _filtersSearch;
              }
            });
          },
        )
      );
    }
  }


  Iterable<Widget> get propertiesCityGtaCentralWidgets sync* {
    for (PropertiesCityGtaCentral propertiesCityGtaCentral in _propertiesCityGtaCentral) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 160,
            alignment: Alignment.center,
            child: Text(propertiesCityGtaCentral.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kSecondaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: isLoggedIn ? _filtersSearchCityIsLoggedIn.contains(propertiesCityGtaCentral.name) : _filtersSearchCity.contains(propertiesCityGtaCentral.name),
          onSelected: ( bool selected ) {
            setState(() {
              if(isLoggedIn){
                selected ? _filtersSearchCityIsLoggedIn.add(propertiesCityGtaCentral.name) : _filtersSearchCityIsLoggedIn.removeWhere((String name) => name == propertiesCityGtaCentral.name) ;
                Preferences.userFiltersCityIsLoggedIn = _filtersSearchCityIsLoggedIn; 
              }else{
                selected ? _filtersSearchCity.add(propertiesCityGtaCentral.name) : _filtersSearchCity.removeWhere((String name) => name == propertiesCityGtaCentral.name) ;
                Preferences.userFiltersCity = _filtersSearchCity;
              }
            });            
          },
        )
      );
    }
  }


  Iterable<Widget> get propertiesCityGtaNorthWidgets sync* {
    for ( PropertiesCityGtaNorth propertiesCityGtaNorth in _propertiesCityGtaNorth) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0, ),
        child: ChoiceChip(
          label: Container(
            width: 160,
            alignment: Alignment.center,
            child: Text(propertiesCityGtaNorth.name, style: const TextStyle( fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor, ), ),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kSecondaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: isLoggedIn ? _filtersSearchCityGtaNorthLoggedIn.contains(propertiesCityGtaNorth.name) : _filtersSearchCityGtaNorth.contains(propertiesCityGtaNorth.name),
          onSelected: ( bool selected ) {
            setState(() {
              if ( isLoggedIn ) {
                selected ? _filtersSearchCityGtaNorthLoggedIn.add(propertiesCityGtaNorth.name) : _filtersSearchCityGtaNorthLoggedIn.removeWhere((String name) => name == propertiesCityGtaNorth.name) ;
                Preferences.userFiltersCityGtaNorthLoggedIn = _filtersSearchCityGtaNorthLoggedIn;
              } else {
                selected ? _filtersSearchCityGtaNorth.add(propertiesCityGtaNorth.name) : _filtersSearchCityGtaNorth.removeWhere((String name) => name == propertiesCityGtaNorth.name) ;
                Preferences.userFiltersCityGtaNorth = _filtersSearchCityGtaNorth;
              }
            });
          },
        ),
      );
    }
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


class PropertiesCityGtaCentral {
  const PropertiesCityGtaCentral(this.name);
  final String name;
}

class PropertiesCityGtaNorth {
  const PropertiesCityGtaNorth(this.name);
  final String name;
}

class PropertiesTypes {
  const PropertiesTypes(this.name);
  final String name;
}

class PropertiesRooms {
  const PropertiesRooms(this.name);
  final String name;
}

class PropertiesBaths {
  const PropertiesBaths(this.name);
  final String name;
}
