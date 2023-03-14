import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';


class FiltersTrWest extends StatefulWidget {
  const FiltersTrWest({Key? key}) : super(key: key);

  @override
  State<FiltersTrWest> createState() => _FiltersTrWestState();
}

class _FiltersTrWestState extends State<FiltersTrWest> {

  late List<bool> _openCloseIcons;
  late List<PropertiesTrWest> _propertiesTrWest;
  late List<String> _filtersTrWest;

  bool citySelectAll = Preferences.filtersTrWest.length == 5 ? true : false ;

  List<List<String>> torontoWestDistricts = [
    ['Toronto W01','Toronto W02'],
    ['Toronto W02','Toronto W03'],
    ['Toronto W07','Toronto W08','Toronto W09','Toronto W10'],
    ['Toronto W06'],
    ['Toronto W04','Toronto W05'],
  ];

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
    ];
    
    _propertiesTrWest = <PropertiesTrWest>[
      const PropertiesTrWest('High Park and around'),
      const PropertiesTrWest('Junction and around'),
      const PropertiesTrWest('Etobicoke'),
      const PropertiesTrWest('Mimico'),
      const PropertiesTrWest('Other'),
    ];

    _filtersTrWest = Preferences.filtersTrWest;
  }

  @override
  Widget build(BuildContext context) {
    
    return 
      ExpansionTile(
        title: const Text('Toronto West', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
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
                    for (var element in _propertiesTrWest) {
                      _filtersTrWest.remove(element.name) ;
                    }
                    if(citySelectAll) {
                      citySelectAll = false;
                      for (var element in _propertiesTrWest) {
                        _filtersTrWest.remove(element.name) ;

                        for(int i = 0; i < torontoWestDistricts[_propertiesTrWest.indexOf(element)].length; ++i){
                          if(Provider.of<FilterProvider>(context, listen: false).filtersLocation.contains(torontoWestDistricts[_propertiesTrWest.indexOf(element)][i])){
                            Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == torontoWestDistricts[_propertiesTrWest.indexOf(element)][i]);
                          }
                        } 

                      }
                    } else {
                      citySelectAll = true;
                      for (var element in _propertiesTrWest) {
                        _filtersTrWest.add(element.name) ;
                        Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation, ...torontoWestDistricts[_propertiesTrWest.indexOf(element)]];
                      }
                    }
                    Preferences.filtersTrWest = _filtersTrWest;
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
            children: propertiesTrWestWidgets.toList(),
          ),
          const SizedBox( height: 16.0,),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[0] = expanded );
        },
      );    
  }

  Iterable<Widget> get propertiesTrWestWidgets sync* {
    for (PropertiesTrWest propertiesTrWest in _propertiesTrWest) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesTrWest.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersTrWest.contains(propertiesTrWest.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersTrWest.contains(propertiesTrWest.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersTrWest.add(propertiesTrWest.name) : _filtersTrWest.removeWhere((String name) => name == propertiesTrWest.name) ;
                Preferences.filtersTrWest = _filtersTrWest;

                if(selected){
                  Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation,  ...torontoWestDistricts[_propertiesTrWest.indexOf(propertiesTrWest)]];
                } else {
                  for(int i = 0; i < torontoWestDistricts[_propertiesTrWest.indexOf(propertiesTrWest)].length; ++i){
                    if(Provider.of<FilterProvider>(context, listen: false).filtersLocation.contains(torontoWestDistricts[_propertiesTrWest.indexOf(propertiesTrWest)][i])){
                      Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == torontoWestDistricts[_propertiesTrWest.indexOf(propertiesTrWest)][i]);
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
}

class PropertiesTrWest {
  const PropertiesTrWest(this.name);
  final String name;
}