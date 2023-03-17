import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';
import 'package:flutter_black_white/filters/filters_property_icons.dart';


class FiltersPropertyHouse extends StatefulWidget {
  const FiltersPropertyHouse({Key? key}) : super(key: key);

  @override
  State<FiltersPropertyHouse> createState() => _FiltersPropertyHouseState();
}

class _FiltersPropertyHouseState extends State<FiltersPropertyHouse> {

  late List<bool> _openCloseIcons;
  late List<PropertiesHouse> _propertiesHouse;
  late List<PropertiesHouseOthers> _propertiesHouseOthers;
  late List<String> _filtersPropertyHouse;

  List<List<String>> propertyTypeHouse = [
    ['Duplex'],
    ['Triplex'],
    ['Fourplex'],
    ['Multiplex'],
  ];

  List<List<String>> propertyTypeHouseOther = [
    ['Vacant Land'],
    ['Cottage','Farm','Link','Land','Rural Resid','Mobile/Trailer','Other'],
  ];

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
      false,
      false,
      false,
    ]; 

    _propertiesHouse = <PropertiesHouse>[
      const PropertiesHouse('DUPLEX'),
      const PropertiesHouse('TRIPLEX'),
      const PropertiesHouse('FOURPLEX'),
      const PropertiesHouse('OTHER MULTIPLEX'),
    ];

    _propertiesHouseOthers = <PropertiesHouseOthers>[
      const PropertiesHouseOthers('VACANT LAND'),
      const PropertiesHouseOthers('OTHER'),
    ];

    _filtersPropertyHouse = Preferences.filterPropertyType;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            const FiltersPropertyIcons(),
            ExpansionTile(
              title: const Text('Other', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
              trailing: Icon(
                _openCloseIcons[1] ? Icons.remove : Icons.add,
                color: kPrimaryColor,
                size: 18.0,
              ),
              children: [
                const SizedBox( height: 7.0, ),
                const BlueDivider(),
                ExpansionTile(
                  title: const Text('Multiplex', style: TextStyle(color: kPrimaryColor),),
                  trailing: Icon(
                    _openCloseIcons[2] ? Icons.remove : Icons.add,
                    color: kPrimaryColor,
                    size: 18.0,
                  ),
                  children: [
                    const SizedBox( height: 1.0, ),
                    const SizedBox( height: 14.0, ),
                    Wrap(
                      children: propertiesHouseWidgets.toList(),
                    ),
                    const SizedBox( height: 14.0, ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _openCloseIcons[2] = expanded );
                  },
                ),
                const BlueDivider(), 
                const SizedBox( height: 24.0, ),
                Wrap(
                  children: propertiesHouseOthersWidgets.toList(),
                ),
                const SizedBox( height: 18.0,)
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => _openCloseIcons[1] = expanded );
              },
            ),            
          ],
        )
      ),
    );    
  }


  Iterable<Widget> get propertiesHouseWidgets sync* {
    for (PropertiesHouse propertiesHouse in _propertiesHouse) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 6.0 ),
        child: ChoiceChip(
          label: Container(
            width: 140,          
            alignment: Alignment.center,
            child: Text(propertiesHouse.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersPropertyHouse.contains(propertiesHouse.name) ? Colors.white : kPrimaryColor),),
          ),
          backgroundColor: Colors.white,
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersPropertyHouse.contains(propertiesHouse.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersPropertyHouse.add(propertiesHouse.name) : _filtersPropertyHouse.removeWhere((String name) => name == propertiesHouse.name) ;
                Preferences.filterPropertyType = _filtersPropertyHouse; 


                if(selected){
                  Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse = [...Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse,  ...propertyTypeHouse[_propertiesHouse.indexOf(propertiesHouse)]];
                } else {
                  for(int i = 0; i < propertyTypeHouse[_propertiesHouse.indexOf(propertiesHouse)].length; ++i){
                    if(Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse.contains(propertyTypeHouse[_propertiesHouse.indexOf(propertiesHouse)][i])){
                      Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse.removeWhere((String name) => name == propertyTypeHouse[_propertiesHouse.indexOf(propertiesHouse)][i]);
                    }
                  }                
                }  
                Preferences.filtersPropertyTypeHouse = Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse;
          
                //print(Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse);

            });
          },
        )
      );
    }
  }

  Iterable<Widget> get propertiesHouseOthersWidgets sync* {
    for (PropertiesHouseOthers propertiesHouseOthers in _propertiesHouseOthers) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 6.0 ),
        child: ChoiceChip(
          label: Container(
            width: 140,          
            alignment: Alignment.center,
            child: Text(propertiesHouseOthers.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersPropertyHouse.contains(propertiesHouseOthers.name) ? Colors.white : kPrimaryColor),),
          ),
          backgroundColor: Colors.white,
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersPropertyHouse.contains(propertiesHouseOthers.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersPropertyHouse.add(propertiesHouseOthers.name) : _filtersPropertyHouse.removeWhere((String name) => name == propertiesHouseOthers.name) ;
                Preferences.filterPropertyType = _filtersPropertyHouse;

                if(selected){
                  Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse = [...Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse,  ...propertyTypeHouseOther[_propertiesHouseOthers.indexOf(propertiesHouseOthers)]];
                } else {
                  for(int i = 0; i < propertyTypeHouseOther[_propertiesHouseOthers.indexOf(propertiesHouseOthers)].length; ++i){
                    if(Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse.contains(propertyTypeHouseOther[_propertiesHouseOthers.indexOf(propertiesHouseOthers)][i])){
                      Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse.removeWhere((String name) => name == propertyTypeHouseOther[_propertiesHouseOthers.indexOf(propertiesHouseOthers)][i]);
                    }
                  }                
                } 
                Preferences.filtersPropertyTypeHouse = Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse;

                //print(Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse);
            });
          },
        )
      );
    }
  }
}


class PropertiesHouse {
  const PropertiesHouse(this.name);
  final String name;
}

class PropertiesHouseOthers {
  const PropertiesHouseOthers(this.name);
  final String name;
}