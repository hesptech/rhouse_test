import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersLocationTopbts extends StatefulWidget {
  const FiltersLocationTopbts({Key? key}) : super(key: key);

  @override
  State<FiltersLocationTopbts> createState() => _FiltersLocationTopbtsState();
}

class _FiltersLocationTopbtsState extends State<FiltersLocationTopbts> {
  late List<PropertiesTopbts> _propertiesTopbts;
  late List<String> _filtersTopbts;


  List<String> torontoBts = [
    'Toronto C01',
    'Toronto C02',
    'Toronto C03',
    'Toronto C04',
    'Toronto C06',
    'Toronto C07',
    'Toronto C08',
    'Toronto C09',
    'Toronto C10',
    'Toronto C11',
    'Toronto C13',
    'Toronto C15',
    'Toronto E01',
    'Toronto E02',
    'Toronto E03',
    'Toronto E04',
    'Toronto E11',
    'Toronto W01',
    'Toronto W02',
    'Toronto W03',
    'Toronto W04',
    'Toronto W05',
    'Toronto W06',
    'Toronto W07',
    'Toronto W08',
    'Toronto W09',
    'Toronto W10',    
  ];

  List<String> suburbsBts = [
    'Toronto W07','Toronto W08','Toronto W09','Toronto W10',
    'Missisauga',
    'Brampton',
    'Oakville',
    'Milton',
    'Burlington',
    'Halton Hills',
    'Caledon',
    'Vaughan',
    'Markham',
    'Richmond hill',
    'Newmarket',
    'Aurora',
    'King',
    'Whitchurch-Stouffville',
    'Georgina',
    'East Gwillingbury',
    'Scarborough',
    'Pickering',
    'Ajax',
    'Whitby',
    'Oshawa',
    'Clarington',
    'Uxbridge',
    'Scugog',
    'Brock',
    'Hamilton',
    'Barrie',
    'Peterborough',   
  ];


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
              color: Preferences.filtersLocationTopbts.contains(propertiesTopbts.name) ? Colors.white : kPrimaryColor),
            ),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: Preferences.filtersLocationTopbts.contains(propertiesTopbts.name),
          onSelected: ( bool selected ) {
            setState(() {
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


class PropertiesTopbts {
  const PropertiesTopbts(this.name);
  final String name;
}