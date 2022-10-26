import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

//import '../helpers/widgets_formatting.dart';


class FiltersStyle extends StatefulWidget {
  const FiltersStyle({Key? key}) : super(key: key);

  @override
  State<FiltersStyle> createState() => _FiltersStyleState();
}

class _FiltersStyleState extends State<FiltersStyle> {

  late List<bool> _openCloseIcons;
  late List<PropertiesStyle> _propertiesStyle;
  late List<String> _filtersStyle;

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
    
    _propertiesStyle = <PropertiesStyle>[
      const PropertiesStyle('Bungalow'),
      const PropertiesStyle('2 stories or more'),
      const PropertiesStyle('Sidesplit'),
      const PropertiesStyle('Backsplit'),
    ];
    _filtersStyle = [];
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('STYLE', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, ),),
      trailing: Icon(
        _openCloseIcons[1] ? Icons.remove : Icons.add,
        //Icons.add,
        color: kPrimaryColor,
        size: 18.0,
      ),
      children: [
        Wrap(
          children: propertiesStyleWidgets.toList(),
        ),
        const SizedBox( height: 14.0,)
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _openCloseIcons[1] = expanded );
      },
    );    
  }

  Iterable<Widget> get propertiesStyleWidgets sync* {
    for (PropertiesStyle propertiesStyle in _propertiesStyle) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 160,
            alignment: Alignment.center,
            child: Text(propertiesStyle.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersStyle.contains(propertiesStyle.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersStyle.contains(propertiesStyle.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersStyle.add(propertiesStyle.name) : _filtersStyle.removeWhere((String name) => name == propertiesStyle.name) ;
                //Preferences.filtersStyleLoggedOut = _filtersStyle;
            });            
          },
        )
      );
    }
  }
}


class PropertiesStyle {
  const PropertiesStyle(this.name);
  final String name;
}