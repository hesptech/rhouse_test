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
  late List<String> _filtersSearch;
  late List<String> _filtersSearchIsLoggedIn;

  final isLoggedIn = Preferences.isLoggedIn;

  //double _currentSliderValue = 0.0;
  var selectedRange = const RangeValues(500000, 5000000);

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
      const PropertiesRooms('1'),
      const PropertiesRooms('2'),
      const PropertiesRooms('3'),
      const PropertiesRooms('4'),
      const PropertiesRooms('+5'),
    ];
    _filtersSearch = Preferences.userFilters;
    _filtersSearchIsLoggedIn = Preferences.userFiltersIsLoggedIn;
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

          Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 28.0),
            child: Column(
              children: [
                const Text('Price Range', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: kSecondaryColor),),
                const SizedBox(height: 14.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${selectedRange.start.round().toString()} \n or less', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, ),),
                    Text('\$${selectedRange.end.round().toString()} \n or more', textAlign: TextAlign.right, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, ),),
                  ],
                ),
                RangeSlider(
                  activeColor: const Color(0xFF2E3191),
                  inactiveColor: const Color(0xFF58595B),
                  min: 0,
                  max: 5000000,
                  //divisions: 10,
                  labels: RangeLabels('${selectedRange.start}', '${selectedRange.end}'),
                  values: selectedRange,
                  onChanged: (RangeValues newRange) {
                    setState(() => selectedRange = newRange);
                  },
                ),
              ],
            ),
          ),

          const Text(
            'City', 
            style: TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.w500, 
              color: kSecondaryColor
            ),
          ),
          Padding(
            //padding: const EdgeInsets.symmetric( horizontal: 28.0, vertical: 8.0 ),
            padding: const EdgeInsets.fromLTRB(28.0, 14.0, 28.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('GTA - Central', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                Text('Select all', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
              ],
            ),
          ),
          Wrap(
            children: propertiesCityGtaCentralWidgets.toList(),
          ),

          const SizedBox(height: 16.0,),
          Padding(
            padding: const EdgeInsets.fromLTRB(28.0, 8.0, 28.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('GTA - North', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                Text('Select all', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
              ],
            ),              
          ),
          Wrap(
            children: propertiesCityGtaNorthWidgets.toList(),
          ),

          // TYPES
          ExpansionTile(
            title: const Text('Property Type', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E3191)),),
            children: [
              Wrap(
                children: propertiesTypesWidgets.toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionChip(
                    backgroundColor: Colors.grey,
                    avatar: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.done_all_outlined, size: 18, color: Color.fromARGB(255, 61, 62, 78)),
                    ),
                    label: const Text(' All ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 61, 62, 78)),), 
                    onPressed: () {
                        setState(() {
                          for (var element in _propertiesTypes) {
                            _filtersSearch.add(element.name);
                          }   
                        }); 
                    }
                  ),
                  const SizedBox( width: 5.0, ),
                  ActionChip(
                    backgroundColor: Colors.grey,
                    avatar: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.remove_done_outlined, size: 18, color: Color.fromARGB(255, 61, 62, 78)),
                    ),
                    label: const Text('None', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 61, 62, 78)),), 
                    onPressed: () {
                        setState(() {
                          for (var element in _propertiesTypes) {
                            _filtersSearch.removeWhere((String name) => name == element.name);
                          }   
                        });
                    }
                  )
                ],
              ),
            ],
          ),

          // ROOMS
          ExpansionTile(
            title: const Text('Rooms', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E3191)),),
            children: [
              Wrap(
                children: propertiesRoomsWidgets.toList(),
              ),
              const SizedBox(height: 10.0,),
            ],
          ),
          Text('Selected: ${_filtersSearch.join(', ')}'),
          Text('Selected isLogged: ${_filtersSearchIsLoggedIn.join(', ')}'),
          Text('${Preferences.userFilters}'),
          Text('Log: ${Preferences.isLoggedIn}'),
    
        ],
      ),
    );
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
          selected: isLoggedIn ?  _filtersSearchIsLoggedIn.contains(propertiesCityGtaCentral.name) : _filtersSearch.contains(propertiesCityGtaCentral.name),
          onSelected: ( bool selected ) {
            setState(() {
              if ( isLoggedIn ) {
                selected ? _filtersSearchIsLoggedIn.add(propertiesCityGtaCentral.name) : _filtersSearchIsLoggedIn.removeWhere((String name) => name == propertiesCityGtaCentral.name) ;
                Preferences.userFiltersIsLoggedIn = _filtersSearchIsLoggedIn;                 
              } else {
                selected ? _filtersSearch.add(propertiesCityGtaCentral.name) : _filtersSearch.removeWhere((String name) => name == propertiesCityGtaCentral.name) ;
                Preferences.userFilters = _filtersSearch;
              }
            });
          },
        )
      );
    }
  }


  Iterable<Widget> get propertiesCityGtaNorthWidgets sync* {
    for (PropertiesCityGtaNorth propertiesCityGtaNorth in _propertiesCityGtaNorth) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 160,
            alignment: Alignment.center,
            child: Text(propertiesCityGtaNorth.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kSecondaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersSearch.contains(propertiesCityGtaNorth.name),
          onSelected: ( bool selected ) {
            setState(() {
              if(selected){
                _filtersSearch.add(propertiesCityGtaNorth.name);
              }else{
                _filtersSearch.removeWhere((String name) => name == propertiesCityGtaNorth.name);
              }
              Preferences.userFilters = _filtersSearch;
            });
          },
        )
      );
    }
  }

  
  Iterable<Widget> get propertiesTypesWidgets sync* {
    for (PropertiesTypes propertiesTypes in _propertiesTypes) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 6.0 ),
        child: ChoiceChip(
          label: Text(propertiesTypes.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 61, 62, 78)),),
          selectedColor: const Color(0xFF0BB48B),
          elevation: 6.0,
          shadowColor: Colors.grey[900],
          selected: _filtersSearch.contains(propertiesTypes.name),
          onSelected: ( bool selected ) {
            setState(() {
              if(selected){
                _filtersSearch.add(propertiesTypes.name);
              }else{
                _filtersSearch.removeWhere((String name) => name == propertiesTypes.name);
              }
            });
          },
        )
      );
    }
  }


  Iterable<Widget> get propertiesRoomsWidgets sync* {
    for (PropertiesRooms propertiesRooms in _propertiesRooms) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 6.0 ),
        child: ChoiceChip(
          label: Text(propertiesRooms.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 61, 62, 78)),),
          selectedColor: const Color(0xFF0BB48B),
          elevation: 6.0,
          shadowColor: Colors.grey[900],
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
