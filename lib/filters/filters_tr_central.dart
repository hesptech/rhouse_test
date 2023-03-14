import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';


class FiltersTrCentral extends StatefulWidget {
  const FiltersTrCentral({Key? key}) : super(key: key);

  @override
  State<FiltersTrCentral> createState() => _FiltersTrCentralState();
}

class _FiltersTrCentralState extends State<FiltersTrCentral> {

  late List<bool> _openCloseIcons;
  late List<PropertiesTrCentral> _propertiesTrCentral;
  late List<String> _filtersTrCentral;

  bool citySelectAll = Preferences.filtersTrCentral.length == 4 ? true : false ;

  List<List<String>> torontoCentral = [
    ['Toronto C01','Toronto C08'],
    ['Toronto C02','Toronto C03','Toronto C04','Toronto C09','Toronto C10'],
    ['Toronto C11'],
    ['Toronto C04','Toronto C06','Toronto C07','Toronto C11','Toronto C13','Toronto C15'],
  ];
  late List<List<String>> trCentral = [];
  List<String> locationsCodes = [];
  //final List torontoCentral = [];

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
    ]; 

    _propertiesTrCentral = <PropertiesTrCentral>[
      const PropertiesTrCentral('Downtown Toronto'),
      const PropertiesTrCentral('Midtown Toronto'),
      const PropertiesTrCentral('Leaside'),
      const PropertiesTrCentral('Toronto North York'),
    ];
    _filtersTrCentral = Preferences.filtersTrCentral;
    locationsCodes = Preferences.userFiltersCity;
    //trCentral = [[]];
  }

  @override
  Widget build(BuildContext context) {

    //final filterProvider = Provider.of<FilterProvider>( context );
    //final filtersLocation = filterProvider.filtersLocation;

    return 
      ExpansionTile(
        title: const Text('Toronto Central', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
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
                    for (var element in _propertiesTrCentral) {
                      _filtersTrCentral.remove(element.name);
                    } 
                    if(citySelectAll) {
                      citySelectAll = false;
                      for (var element in _propertiesTrCentral) {
                        _filtersTrCentral.remove(element.name);


                        for(int i = 0; i < torontoCentral[_propertiesTrCentral.indexOf(element)].length; ++i){
                          if(locationsCodes.contains(torontoCentral[_propertiesTrCentral.indexOf(element)][i])){
                            locationsCodes.removeWhere((String name) => name == torontoCentral[_propertiesTrCentral.indexOf(element)][i]);
                            Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == torontoCentral[_propertiesTrCentral.indexOf(element)][i]);
                          }
                        } 

                      }
                      //locationsCodes = [];
                    } else {
                      citySelectAll = true;
                      for (var element in _propertiesTrCentral) {
                        _filtersTrCentral.add(element.name);
                        locationsCodes = [...locationsCodes,  ...torontoCentral[_propertiesTrCentral.indexOf(element)]];
                        Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation,  ...torontoCentral[_propertiesTrCentral.indexOf(element)]];
                      } 
                    }
                    Preferences.filtersTrCentral = _filtersTrCentral;
                    Preferences.userFiltersCity = locationsCodes; 

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
                child: Text( citySelectAll ? 'Unselect all' : 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor, ),),
              ),
              const SizedBox( width: 28.0),
            ],
          ),
          Wrap(
            children: propertiesTrCentralWidgets.toList(),
          ),
          const SizedBox( height: 16.0,),
          //Text('Prefs.filtersTrCentral: ${Preferences.filtersTrCentral}'),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[0] = expanded );
        },
      );
  }


  Iterable<Widget> get propertiesTrCentralWidgets sync* {
    for (PropertiesTrCentral propertiesTrCentral in _propertiesTrCentral) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesTrCentral.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersTrCentral.contains(propertiesTrCentral.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersTrCentral.contains(propertiesTrCentral.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersTrCentral.add(propertiesTrCentral.name) : _filtersTrCentral.removeWhere((String name) => name == propertiesTrCentral.name) ;
                //Preferences.filtersTrCentral = _filtersTrCentral;
                //selected ? trCentral.add(torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)]) : trCentral.removeWhere((String name) => name == torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)]) ;
                selected ? trCentral.add(torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)]) : trCentral.removeWhere((List name) => name == torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)]) ;
                //locationsCodes = [ ...locationsCodes, torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)]];
                Preferences.filtersTrCentral = _filtersTrCentral;
                if(selected){
                  locationsCodes = [...locationsCodes,  ...torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)]];
                  Provider.of<FilterProvider>(context, listen: false).filtersLocation = [...Provider.of<FilterProvider>(context, listen: false).filtersLocation,  ...torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)]];
                } else {
                  for(int i = 0; i < torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)].length; ++i){
                    if(locationsCodes.contains(torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)][i])){
                      locationsCodes.removeWhere((String name) => name == torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)][i]);
                      Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == torontoCentral[_propertiesTrCentral.indexOf(propertiesTrCentral)][i]);
                    }
                  }                
                }
                Preferences.userFiltersCity = locationsCodes;
                
                //print(Preferences.userFiltersCity);
                //print(Provider.of<FilterProvider>(context, listen: false).filtersLocation);
            });            
          },
        )
      );
    }
  }
}

class PropertiesTrCentral {
  const PropertiesTrCentral(this.name);
  final String name;
}