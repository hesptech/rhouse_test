import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/config/filters_data_locations.dart';

class FiltersTrEast extends StatefulWidget {
  const FiltersTrEast({Key? key}) : super(key: key);

  @override
  State<FiltersTrEast> createState() => _FiltersTrEastState();
}

class _FiltersTrEastState extends State<FiltersTrEast> {
  late List<bool> _openCloseIcons;
  late List<PropertiesTrEast> _propertiesTrEast;
  late List<String> _filtersTrEast;

  bool citySelectAll = Preferences.filtersTrEast.length == 5  ? true : false ;

  List<List<String>> torontoEastDistricts = codesTrEast;


  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
    ]; 

    _propertiesTrEast = <PropertiesTrEast>[
      const PropertiesTrEast('Danforth'),
      const PropertiesTrEast('Beaches'),
      const PropertiesTrEast('East York'),
      const PropertiesTrEast('Leslieville/Riverdale'),
      const PropertiesTrEast('Scarborough'),
    ];

    _filtersTrEast = Preferences.filtersTrEast;

    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final filtersLocationProvider = Provider.of<FilterProvider>(context, listen: false).filtersLocation;
    }); */
  }

  @override
  Widget build(BuildContext context) {

    return 
      ExpansionTile(
        initiallyExpanded: true,
        title: const Text('Toronto East', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
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
                    _filtersTrEast = Preferences.filtersTrEast;

                    for (var element in _propertiesTrEast) {
                      _filtersTrEast.remove(element.name) ;
                    }
                    if(citySelectAll) {
                      citySelectAll = false;
                      for (var element in _propertiesTrEast) {
                        _filtersTrEast.remove(element.name) ;

                        for(int i = 0; i < torontoEastDistricts[_propertiesTrEast.indexOf(element)].length; ++i){
                          if(Provider.of<FilterProvider>(context, listen: false).filtersLocation.contains(torontoEastDistricts[_propertiesTrEast.indexOf(element)][i])){
                            Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == torontoEastDistricts[_propertiesTrEast.indexOf(element)][i]);
                          }
                        } 

                      }
                    } else {
                      citySelectAll = true;
                      for (var element in _propertiesTrEast) {
                        _filtersTrEast.add(element.name) ;
                        Provider.of<FilterProvider>(context, listen: false).filtersLocation = [ ...Provider.of<FilterProvider>(context, listen: false).filtersLocation, ...torontoEastDistricts[_propertiesTrEast.indexOf(element)]];
                      }
                    }
                    Preferences.filtersTrEast = _filtersTrEast ;
                    Preferences.userFiltersCity = Provider.of<FilterProvider>(context, listen: false).filtersLocation;
                    
                    //print(Preferences.userFiltersCity);
                    //print(Provider.of<FilterProvider>(context, listen: false).filtersLocation); 
                  });  
                }, 
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size( 50.0, 30.0 ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(citySelectAll ? 'Unselect all' : 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
              ),
              const SizedBox( width: 28.0),
            ],
          ),
          Wrap(
            children:  propertiesTrEastWidgets.toList(),
          ),
          const SizedBox( height: 16.0,),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[0] = expanded );
        },
      );   
  }


  Iterable<Widget> get propertiesTrEastWidgets sync* {
    for ( PropertiesTrEast propertiesTrEast in _propertiesTrEast) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0, ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesTrEast.name, style: TextStyle( fontSize: 16, fontWeight: FontWeight.w400, color: _filtersTrEast.contains(propertiesTrEast.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersTrEast.contains(propertiesTrEast.name),
          onSelected: ( bool selected ) {
            setState(() {

                Provider.of<FilterProvider>(context, listen: false).resetLocationTopbts();
                _filtersTrEast = Preferences.filtersTrEast;

                selected ? _filtersTrEast.add(propertiesTrEast.name) : _filtersTrEast.removeWhere((String name) => name == propertiesTrEast.name) ;
                Preferences.filtersTrEast = _filtersTrEast;

                if(selected){
                  Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation,  ...torontoEastDistricts[_propertiesTrEast.indexOf(propertiesTrEast)]];
                } else {
                  for(int i = 0; i < torontoEastDistricts[_propertiesTrEast.indexOf(propertiesTrEast)].length; ++i){
                    if(Provider.of<FilterProvider>(context, listen: false).filtersLocation.contains(torontoEastDistricts[_propertiesTrEast.indexOf(propertiesTrEast)][i])){
                      Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == torontoEastDistricts[_propertiesTrEast.indexOf(propertiesTrEast)][i]);
                    }
                  }                
                }
                Preferences.userFiltersCity = Provider.of<FilterProvider>(context, listen: false).filtersLocation;
                
                //print(Preferences.userFiltersCity);
                //print(Provider.of<FilterProvider>(context, listen: false).filtersLocation);
            });
          },
        ),
      );
    }
  }
}


class PropertiesTrEast {
  const PropertiesTrEast(this.name);
  final String name;
}
