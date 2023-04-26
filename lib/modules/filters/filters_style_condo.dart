import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersStyleCondo extends StatefulWidget {
  const FiltersStyleCondo({Key? key}) : super(key: key);

  @override
  State<FiltersStyleCondo> createState() => _FiltersStyleCondoState();
}

class _FiltersStyleCondoState extends State<FiltersStyleCondo> {

  late List<bool> _openCloseIcons;
  late List<PropertiesStyleCondo> _propertiesStyleCondo;
  late List<String> _filtersStyleCondo;

  List<List<String>> indexStyleCondo = [
    ['Apartment'],
    ['Loft'],
    ['Stacked Townhse'],
    ['Multi-Level'],
    ['2-Storey','3-Storey','Bungalow']
  ];

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
    ];
    
    _propertiesStyleCondo = <PropertiesStyleCondo>[
      const PropertiesStyleCondo('Apartment'),
      const PropertiesStyleCondo('Loft'),
      const PropertiesStyleCondo('Stacked Townhouse'),
      const PropertiesStyleCondo('Multi-level'),
      const PropertiesStyleCondo('Other'),
    ];
    
    _filtersStyleCondo = Preferences.filtersStyleCondo;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 12.0 ),
      child: ExpansionTile(
        title: const Text('STYLE', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, ),),
        trailing: Icon(
          _openCloseIcons[0] ? Icons.remove : Icons.add,
          color: kPrimaryColor,
          size: 18.0,
        ),
        children: [
          Wrap(
            children: propertiesStyleCondoWidgets.toList(),
          ),
          const SizedBox( height: 14.0,),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[0] = expanded );
        },
      ),
    );     
  }

  Iterable<Widget> get propertiesStyleCondoWidgets sync* {
    for (PropertiesStyleCondo propertiesStyle in _propertiesStyleCondo) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 160,
            alignment: Alignment.center,
            child: Text(propertiesStyle.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersStyleCondo.contains(propertiesStyle.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersStyleCondo.contains(propertiesStyle.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersStyleCondo.add(propertiesStyle.name) : _filtersStyleCondo.removeWhere((String name) => name == propertiesStyle.name) ;
                Preferences.filtersStyleCondo = _filtersStyleCondo;

                if(selected){
                  Provider.of<FilterProvider>(context, listen: false).filtersStyleCondo = [...Provider.of<FilterProvider>(context, listen: false).filtersStyleCondo,  ...indexStyleCondo[_propertiesStyleCondo.indexOf(propertiesStyle)]];
                } else {
                  for(int i = 0; i < indexStyleCondo[_propertiesStyleCondo.indexOf(propertiesStyle)].length; ++i){
                    if(Provider.of<FilterProvider>(context, listen: false).filtersStyleCondo.contains(indexStyleCondo[_propertiesStyleCondo.indexOf(propertiesStyle)][i])){
                      Provider.of<FilterProvider>(context, listen: false).filtersStyleCondo.removeWhere((String name) => name == indexStyleCondo[_propertiesStyleCondo.indexOf(propertiesStyle)][i]);
                    }
                  }                
                }
                Preferences.setfiltersIndexStyleCondo(Provider.of<FilterProvider>(context, listen: false).filtersStyleCondo);

                //print(Provider.of<FilterProvider>(context, listen: false).filtersStyleCondo);
                //print(Preferences.filtersStyleCondo);
                //print(Preferences.getfiltersIndexStyleCondo());
            });            
          },
        )
      );
    }
  }
}

class PropertiesStyleCondo {
  const PropertiesStyleCondo(this.name);
  final String name;
}