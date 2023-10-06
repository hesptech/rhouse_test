import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/config/filters_data_locations.dart';

class FiltersGtaNorth extends StatefulWidget {
  const FiltersGtaNorth({Key? key}) : super(key: key);

  @override
  State<FiltersGtaNorth> createState() => _FiltersGtaNorthState();
}

class _FiltersGtaNorthState extends State<FiltersGtaNorth> {

  late List<bool> _openCloseIcons;
  late List<PropertiesGtaNorth> _propertiesGtaNorth;
  late List<PropertiesGtaNorthOther> _propertiesGtaNorthOther;
  late List<String> _filtersGtaNorth;

  bool citySelectAll = Preferences.filtersGtaNorth.length == 9 ? true : false ;

  List<List<String>> gtaNorthDistricts = codesGtaNorth;
  List<List<String>> gtaNorthOtherDistricts = codesGtaNorthOther;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      true,
    ];
    
    _propertiesGtaNorth = <PropertiesGtaNorth>[
      const PropertiesGtaNorth('Vaughan'),
      const PropertiesGtaNorth('Markham'),
      const PropertiesGtaNorth('Richmond Hill'),
    ];
    _propertiesGtaNorthOther = <PropertiesGtaNorthOther>[
      const PropertiesGtaNorthOther('Newmarket'),
      const PropertiesGtaNorthOther('Aurora'),
      const PropertiesGtaNorthOther('King City'),
      const PropertiesGtaNorthOther('Whitchurch/Stouffville'),
      const PropertiesGtaNorthOther('Georgina'),
      const PropertiesGtaNorthOther('East Gwillingbury'),
    ];

    _filtersGtaNorth = Preferences.filtersGtaNorth;
  }

  @override
  Widget build(BuildContext context) {

    return 
      ExpansionTile(
        initiallyExpanded: true,
        title: const Text('GTA North', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
        trailing: Icon(
          _openCloseIcons[0] ? Icons.remove : Icons.add,
          color: kPrimaryColor,
          size: 18.0,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {

                    Provider.of<FilterProvider>(context, listen: false).resetLocationTopbts();
                    _filtersGtaNorth = Preferences.filtersGtaNorth;

                    for (var element in _propertiesGtaNorth) {
                      _filtersGtaNorth.remove(element.name) ;
                    }
                    for (var element in _propertiesGtaNorthOther) {
                      _filtersGtaNorth.remove(element.name) ;
                    }

                    if(citySelectAll) {
                      citySelectAll = false;
                      for (var element in _propertiesGtaNorth) {
                        _filtersGtaNorth.remove(element.name) ;

                        for(int i = 0; i < gtaNorthDistricts[_propertiesGtaNorth.indexOf(element)].length; ++i){
                          if(Provider.of<FilterProvider>(context, listen: false).filtersLocation.contains(gtaNorthDistricts[_propertiesGtaNorth.indexOf(element)][i])){
                            Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == gtaNorthDistricts[_propertiesGtaNorth.indexOf(element)][i]);
                          }
                        }

                      }
                      for (var element in _propertiesGtaNorthOther) {
                        _filtersGtaNorth.remove(element.name) ;

                        for(int i = 0; i < gtaNorthOtherDistricts[_propertiesGtaNorthOther.indexOf(element)].length; ++i){
                          if(Provider.of<FilterProvider>(context, listen: false).filtersLocation.contains(gtaNorthOtherDistricts[_propertiesGtaNorthOther.indexOf(element)][i])){
                            Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == gtaNorthOtherDistricts[_propertiesGtaNorthOther.indexOf(element)][i]);
                          }
                        }

                      }
                    } else {
                      citySelectAll = true;
                      for (var element in _propertiesGtaNorth) {
                        _filtersGtaNorth.add(element.name) ;
                        Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation, ...gtaNorthDistricts[_propertiesGtaNorth.indexOf(element)]];
                      }
                      for (var element in _propertiesGtaNorthOther) {
                        _filtersGtaNorth.add(element.name) ;
                        Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation, ...gtaNorthOtherDistricts[_propertiesGtaNorthOther.indexOf(element)]];
                      }
                    }
                    Preferences.filtersGtaNorth = _filtersGtaNorth ;
                    Preferences.userFiltersCity = Provider.of<FilterProvider>(context, listen: false).filtersLocation;

                    //print(Preferences.userFiltersCity);
                    //print(Provider.of<FilterProvider>(context, listen: false).filtersLocation);
                  });  
                }, 
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size( 50.0, 30.0 ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //alignment: Alignment.centerLeft
                ),
                child: Text(citySelectAll ? 'Unselect all' : 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
              ),
              const SizedBox( width: 28.0),
            ],
          ),
          Wrap(
            children: propertiesGtaNorthWidgets.toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox( width: 16.0, height: 42.0,),
              Text('Other', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ), textAlign: TextAlign.start, ),
            ],
          ),
          Wrap(
            children: propertiesGtaNorthOtherWidgets.toList(),
          ),
          const SizedBox( height: 16.0,),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[0] = expanded );
        },
      );
  }

  Iterable<Widget> get propertiesGtaNorthWidgets sync* {
    for (PropertiesGtaNorth propertiesGtaNorth in _propertiesGtaNorth) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesGtaNorth.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersGtaNorth.contains(propertiesGtaNorth.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersGtaNorth.contains(propertiesGtaNorth.name),
          onSelected: ( bool selected ) {
            setState(() {

                Provider.of<FilterProvider>(context, listen: false).resetLocationTopbts();
                _filtersGtaNorth = Preferences.filtersGtaNorth;

                selected ? _filtersGtaNorth.add(propertiesGtaNorth.name) : _filtersGtaNorth.removeWhere((String name) => name == propertiesGtaNorth.name) ;
                Preferences.filtersGtaNorth = _filtersGtaNorth;

                if(selected){
                  Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation,  ...gtaNorthDistricts[_propertiesGtaNorth.indexOf(propertiesGtaNorth)]];
                } else {
                  for(int i = 0; i < gtaNorthDistricts[_propertiesGtaNorth.indexOf(propertiesGtaNorth)].length; ++i){
                    if(Provider.of<FilterProvider>(context, listen: false).filtersLocation.contains(gtaNorthDistricts[_propertiesGtaNorth.indexOf(propertiesGtaNorth)][i])){
                      Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == gtaNorthDistricts[_propertiesGtaNorth.indexOf(propertiesGtaNorth)][i]);
                    }
                  }                
                }
                Preferences.userFiltersCity = Provider.of<FilterProvider>(context, listen: false).filtersLocation;

                //print(Provider.of<FilterProvider>(context, listen: false).filtersLocation);
                //print(Preferences.userFiltersCity);
            });            
          },
        )
      );
    }
  }

  Iterable<Widget> get propertiesGtaNorthOtherWidgets sync* {
    for (PropertiesGtaNorthOther propertiesGtaNorthOther in _propertiesGtaNorthOther) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0, ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesGtaNorthOther.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersGtaNorth.contains(propertiesGtaNorthOther.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersGtaNorth.contains(propertiesGtaNorthOther.name),
          onSelected: ( bool selected ) {
            setState(() {

                Provider.of<FilterProvider>(context, listen: false).resetLocationTopbts();
                _filtersGtaNorth = Preferences.filtersGtaNorth;
                
                selected ? _filtersGtaNorth.add(propertiesGtaNorthOther.name) : _filtersGtaNorth.removeWhere((String name) => name == propertiesGtaNorthOther.name) ;
                Preferences.filtersGtaNorth = _filtersGtaNorth;

                if(selected){
                  Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation,  ...gtaNorthOtherDistricts[_propertiesGtaNorthOther.indexOf(propertiesGtaNorthOther)]];
                } else {
                  for(int i = 0; i < gtaNorthOtherDistricts[_propertiesGtaNorthOther.indexOf(propertiesGtaNorthOther)].length; ++i){
                    if(Provider.of<FilterProvider>(context, listen: false).filtersLocation.contains(gtaNorthOtherDistricts[_propertiesGtaNorthOther.indexOf(propertiesGtaNorthOther)][i])){
                      Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == gtaNorthOtherDistricts[_propertiesGtaNorthOther.indexOf(propertiesGtaNorthOther)][i]);
                    }
                  }                
                }
                Preferences.userFiltersCity = Provider.of<FilterProvider>(context, listen: false).filtersLocation;

                //print(Provider.of<FilterProvider>(context, listen: false).filtersLocation);
                //print(Preferences.userFiltersCity);
            });            
          },        
        ),
      );
    }
  }
}


class PropertiesGtaNorth {
  const PropertiesGtaNorth(this.name);
  final String name;
}

class PropertiesGtaNorthOther {
  const PropertiesGtaNorthOther(this.name);
  final String name;
}