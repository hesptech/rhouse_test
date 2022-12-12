import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersStyleHouse extends StatefulWidget {
  const FiltersStyleHouse({Key? key}) : super(key: key);

  @override
  State<FiltersStyleHouse> createState() => _FiltersStyleHouseState();
}

class _FiltersStyleHouseState extends State<FiltersStyleHouse> {

  late List<bool> _openCloseIcons;
  late List<PropertiesStyleHouse> _propertiesStyleHouse;
  late List<String> _filtersStyleHouse;

  //bool selectAllStyle = Preferences.filtersStyleLoggedOut.length == 4;
  bool selectAllStyle = false;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
      false,
      false,
      false,
    ];
    
    _propertiesStyleHouse = <PropertiesStyleHouse>[
      const PropertiesStyleHouse('Bungalow'),
      const PropertiesStyleHouse('2 stories or more'),
      const PropertiesStyleHouse('Sidesplit'),
      const PropertiesStyleHouse('Backsplit'),
    ];
    _filtersStyleHouse = Preferences.filtersStyleHouse;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 12.0 ),
      child: ExpansionTile(
        title: const Text('STYLE', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, ),),
        trailing: Icon(
          _openCloseIcons[1] ? Icons.remove : Icons.add,
          color: kPrimaryColor,
          size: 18.0,
        ),
        children: [
          Wrap(
            children: propertiesStyleHouseWidgets.toList(),
          ),
          const SizedBox( height: 14.0,)
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[1] = expanded );
        },
      ),
    );     
  }


  Iterable<Widget> get propertiesStyleHouseWidgets sync* {
    for (PropertiesStyleHouse propertiesStyle in _propertiesStyleHouse) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 160,
            alignment: Alignment.center,
            child: Text(propertiesStyle.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersStyleHouse.contains(propertiesStyle.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersStyleHouse.contains(propertiesStyle.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersStyleHouse.add(propertiesStyle.name) : _filtersStyleHouse.removeWhere((String name) => name == propertiesStyle.name) ;
                Preferences.filtersStyleHouse = _filtersStyleHouse;
            });            
          },
        )
      );
    }
  }
}

class PropertiesStyleHouse {
  const PropertiesStyleHouse(this.name);
  final String name;
}