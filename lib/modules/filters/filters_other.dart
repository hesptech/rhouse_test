import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';

class FiltersOther extends StatefulWidget {
  const FiltersOther({Key? key}) : super(key: key);

  @override
  State<FiltersOther> createState() => _FiltersOtherState();
}

class _FiltersOtherState extends State<FiltersOther> {

  late List<bool> _openCloseIcons;
  late List<PropertiesOther> _propertiesOther;
  late List<String> _filtersOther;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      true,
    ];

    _propertiesOther = <PropertiesOther>[
      const PropertiesOther('Hamilton'),
      const PropertiesOther('Barrie'),
      const PropertiesOther('Peterborough'),
    ];
    _filtersOther = Preferences.filtersOther;
  }

  @override
  Widget build(BuildContext context) {

    return 
      ExpansionTile(
        initiallyExpanded: true,
        title: const Text('Other', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
        trailing: Icon(
          _openCloseIcons[0] ? Icons.remove : Icons.add,
          color: kPrimaryColor,
          size: 18.0,
        ),
        children: [
          Wrap(
            children: propertiesOtherWidgets.toList(),
          ),
          const SizedBox( height: 16.0,),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[0] = expanded );
        },
      );
  }


  Iterable<Widget> get propertiesOtherWidgets sync* {
    for (PropertiesOther propertiesOther in _propertiesOther) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesOther.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersOther.contains(propertiesOther.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersOther.contains(propertiesOther.name),
          onSelected: ( bool selected ) {
            setState(() {

                Provider.of<FilterProvider>(context, listen: false).resetLocationTopbts();
                _filtersOther = Preferences.filtersOther;
                
                selected ? _filtersOther.add(propertiesOther.name) : _filtersOther.removeWhere((String name) => name == propertiesOther.name) ;
                Preferences.filtersOther = _filtersOther;

                selected ? Provider.of<FilterProvider>(context, listen: false).filtersLocation.add(propertiesOther.name) : Provider.of<FilterProvider>(context, listen: false).filtersLocation.removeWhere((String name) => name == propertiesOther.name) ;
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


class PropertiesOther {
  const PropertiesOther(this.name);
  final String name;
}