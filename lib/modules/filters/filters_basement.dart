import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersBasement extends StatefulWidget {
  const FiltersBasement({Key? key}) : super(key: key);

  @override
  State<FiltersBasement> createState() => _FiltersBasementState();
}

class _FiltersBasementState extends State<FiltersBasement> {

  late List<bool> _openCloseIcons;
  late List<PropertiesBasement> _propertiesBasement;
  late List<String> _filtersBasement;

  List<List<String>> indexBasement = [
    ['Finished'],
    ['Unfinished'],
    ['Apartment'],
    ['Sep Entrance'],
  ];

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
    ];
    
    _propertiesBasement = <PropertiesBasement>[
      const PropertiesBasement('Finished'),
      const PropertiesBasement('Unfinished'),
      const PropertiesBasement('Apartment'),
      const PropertiesBasement('Separate Entrance'),
    ];
    _filtersBasement = [];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 12.0 ),
      child: ExpansionTile(
        title: const Text('BASEMENT', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, ),),
        trailing: Icon(
          _openCloseIcons[0] ? Icons.remove : Icons.add,
          //Icons.add,
          color: kPrimaryColor,
          size: 18.0,
        ),
        children: [
          Wrap(
            children: propertiesBasementWidgets.toList(),
          ),
          const SizedBox( height: 14.0, ),
       
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[0] = expanded );
        },
      ),
    );    
  }

  Iterable<Widget> get propertiesBasementWidgets sync* {
    for (PropertiesBasement propertiesBasement in _propertiesBasement) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 160,
            alignment: Alignment.center,
            child: Text(propertiesBasement.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersBasement.contains(propertiesBasement.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersBasement.contains(propertiesBasement.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersBasement.add(propertiesBasement.name) : _filtersBasement.removeWhere((String name) => name == propertiesBasement.name) ;
                Preferences.filtersBasement = _filtersBasement;

                if(selected){
                  Provider.of<FilterProvider>(context, listen: false).filtersBasement = [...Provider.of<FilterProvider>(context, listen: false).filtersBasement,  ...indexBasement[_propertiesBasement.indexOf(propertiesBasement)]];
                } else {
                  for(int i = 0; i < indexBasement[_propertiesBasement.indexOf(propertiesBasement)].length; ++i){
                    if(Provider.of<FilterProvider>(context, listen: false).filtersBasement.contains(indexBasement[_propertiesBasement.indexOf(propertiesBasement)][i])){
                      Provider.of<FilterProvider>(context, listen: false).filtersBasement.removeWhere((String name) => name == indexBasement[_propertiesBasement.indexOf(propertiesBasement)][i]);
                    }
                  }                
                }
                Preferences.setfiltersIndexBasement(Provider.of<FilterProvider>(context, listen: false).filtersBasement);

                /* print(Provider.of<FilterProvider>(context, listen: false).filtersBasement);
                print(Preferences.filtersBasement); */
                //print(Preferences.getfiltersIndexBasement());
            });            
          },
        )
      );
    }
  }
}


class PropertiesBasement {
  const PropertiesBasement(this.name);
  final String name;
}