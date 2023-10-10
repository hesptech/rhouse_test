import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/config/filters_data_locations.dart';

class FiltersLocationTopbts extends StatefulWidget {
  const FiltersLocationTopbts({Key? key}) : super(key: key);

  @override
  State<FiltersLocationTopbts> createState() => _FiltersLocationTopbtsState();
}

class _FiltersLocationTopbtsState extends State<FiltersLocationTopbts> {
  late List<PropertiesTopbts> _propertiesTopbts;
  late List<String> _filtersTopbts;

  List<String> torontoBts = locationTopbt['TORONTO']!;
  List<String> suburbsBts = locationTopbt['Suburbs - Outskirts']!;

  @override
  void initState() {
    super.initState();

    _propertiesTopbts = <PropertiesTopbts>[
      const PropertiesTopbts('TORONTO'),
      const PropertiesTopbts('Suburbs - Outskirts'),
    ];

    _filtersTopbts = Preferences.filtersLocationTopbts;

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const SizedBox( height: 1.0, ),
        Wrap(
          children: propertiesTopbtsWidgets.toList(),
        ),     
      ],
    );    
  }


  Iterable<Widget> get propertiesTopbtsWidgets sync* {
    for (PropertiesTopbts propertiesTopbts in _propertiesTopbts) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0, ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesTopbts.name, style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.w400, 
              color: Provider.of<FilterProvider>(context).filtersLocationTopbts.contains(propertiesTopbts.name) ? Colors.white : kPrimaryColor),
            ),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: Provider.of<FilterProvider>(context).filtersLocationTopbts.contains(propertiesTopbts.name),
          onSelected: ( bool selected ) {
            setState(() {

              _filtersTopbts = Preferences.filtersLocationTopbts;

              _filtersTopbts.contains(propertiesTopbts.name) ? _filtersTopbts.remove(propertiesTopbts.name) : _filtersTopbts.add(propertiesTopbts.name) ;

              Preferences.filtersLocationTopbts = _filtersTopbts;

              if (_filtersTopbts.contains('TORONTO') && _filtersTopbts.contains('Suburbs - Outskirts')) {
                for(int i = 0; i < torontoBts.length; ++i){
                    Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == torontoBts[i]);
                }
                for(int i = 0; i < suburbsBts.length; ++i){
                    Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == suburbsBts[i]);
                }
              } else if (_filtersTopbts.contains('TORONTO')) {
                Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation,  ...torontoBts];
              } else if (_filtersTopbts.contains('Suburbs - Outskirts')){
                Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation,  ...suburbsBts];
              } else {
                for(int i = 0; i < torontoBts.length; ++i){
                    Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == torontoBts[i]);
                }
                for(int i = 0; i < suburbsBts.length; ++i){
                    Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == suburbsBts[i]);
                }
              }

              Provider.of<FilterProvider>(context, listen: false).filtersLocationTopbts = _filtersTopbts;
              Preferences.userFiltersCity = Provider.of<FilterProvider>(context, listen: false).filtersLocation;
              
              //print(Provider.of<FilterProvider>(context, listen: false).filtersLocation);
              //print(Preferences.userFiltersCity);  
               
              Provider.of<FilterProvider>(context, listen: false).resetLocationsOnly();         
              Navigator.pushNamed(context, 'filters_screen');         
            });            
          },        
        ),
      );
    }
  }
}


class PropertiesTopbts {
  const PropertiesTopbts(this.name);
  final String name;
}