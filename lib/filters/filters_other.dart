import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';


class FiltersOther extends StatefulWidget {
  const FiltersOther({Key? key}) : super(key: key);

  @override
  State<FiltersOther> createState() => _FiltersOtherState();
}

class _FiltersOtherState extends State<FiltersOther> {

  late List<bool> _openCloseIcons;
  late List<PropertiesOther> _propertiesOther;
  late List<String> _filtersGtaEast;

  //bool citySelectAllGtaEast = Preferences.filtersGtaEastLoggedOut.length == 4;
  bool citySelectAll = false;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
    ];

    _propertiesOther = <PropertiesOther>[
      const PropertiesOther('Hamilton'),
      const PropertiesOther('Barrie'),
      const PropertiesOther('Peterborough'),
      const PropertiesOther('Other'),
    ];
    _filtersGtaEast = [];
  }

  @override
  Widget build(BuildContext context) {

    return 
      ExpansionTile(
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
            child: Text(propertiesOther.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersGtaEast.contains(propertiesOther.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersGtaEast.contains(propertiesOther.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersGtaEast.add(propertiesOther.name) : _filtersGtaEast.removeWhere((String name) => name == propertiesOther.name) ;
                //Preferences.filtersGtaEastLoggedOut = _filtersGtaEast;
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