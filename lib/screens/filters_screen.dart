import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter/material.dart';


class FiltersScreen extends StatelessWidget {
  const FiltersScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text('Filters'),
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


  //double _currentSliderValue = 0.0;
  var selectedRange = const RangeValues(1000000, 4000000);

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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[


          /* ExpansionTile(
            title: const Text('Price Range', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E3191)),),
            children: <Widget>[
              Text('${_currentSliderValue.round().toString()} to Max.', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF58595B)),),
              Slider(
                thumbColor: const Color(0xFF0BB48B),
                activeColor: const Color(0xFF2E3191),
                inactiveColor: const Color(0xFF58595B),
                min: 0,
                max: 5000000,
                divisions: 10,
                label: _currentSliderValue.round().toString(),
                value: _currentSliderValue, 
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                }, 
              ),
            ],
          ), */



          ExpansionTile(
            title: const Text('Price Range', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E3191)),),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('from ', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF58595B)),),
                  Text('\$ ${selectedRange.start.round().toString()} ', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0BB48B)),),
                  const Text(' to ', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF58595B)),),
                  Text('\$ ${selectedRange.end.round().toString()}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0BB48B)),),
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

          // City
          ExpansionTile(
            title: const Text('City', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E3191)),),
            children: [
              const Text('GTA - Central', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF58595B)),),
              Wrap(
                children: propertiesCityGtaCentralWidgets.toList(),
              ),
              const SizedBox(height: 10.0,),
              const Text('GTA - North', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF58595B)),),
              Wrap(
                children: propertiesCityGtaNorthWidgets.toList(),
              ),
              const SizedBox(height: 10.0,),
            ],
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
          Text('${Preferences.userFilters}'),
    
        ],
      ),
    );
  }


  Iterable<Widget> get propertiesCityGtaCentralWidgets sync* {
    for (PropertiesCityGtaCentral propertiesCityGtaCentral in _propertiesCityGtaCentral) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 6.0 ),
        child: ChoiceChip(
          label: Text(propertiesCityGtaCentral.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 61, 62, 78)),),
          selectedColor: const Color(0xFF0BB48B),
          elevation: 6.0,
          shadowColor: Colors.grey[900],
          selected: _filtersSearch.contains(propertiesCityGtaCentral.name),
          onSelected: ( bool selected ) {
            setState(() {
              if(selected){
                _filtersSearch.add(propertiesCityGtaCentral.name);
              }else{
                _filtersSearch.removeWhere((String name) => name == propertiesCityGtaCentral.name);
              }
              Preferences.userFilters = _filtersSearch;
            });
          },
        )
      );
    }
  }


  Iterable<Widget> get propertiesCityGtaNorthWidgets sync* {
    for (PropertiesCityGtaNorth propertiesCityGtaNorth in _propertiesCityGtaNorth) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 6.0 ),
        child: ChoiceChip(
          label: Text(propertiesCityGtaNorth.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 61, 62, 78)),),
          selectedColor: const Color(0xFF0BB48B),
          elevation: 6.0,
          shadowColor: Colors.grey[900],
          selected: _filtersSearch.contains(propertiesCityGtaNorth.name),
          onSelected: ( bool selected ) {
            setState(() {
              if(selected){
                _filtersSearch.add(propertiesCityGtaNorth.name);
              }else{
                _filtersSearch.removeWhere((String name) => name == propertiesCityGtaNorth.name);
              }
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
