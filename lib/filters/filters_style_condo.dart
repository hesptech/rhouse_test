import 'package:flutter/material.dart';
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
    return ExpansionTile(
      title: const Text('STYLE', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, ),),
      trailing: Icon(
        _openCloseIcons[1] ? Icons.remove : Icons.add,
        color: kPrimaryColor,
        size: 18.0,
      ),
      children: [
        Wrap(
          children: propertiesStyleCondoWidgets.toList(),
        ),
        const SizedBox( height: 14.0,)
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _openCloseIcons[1] = expanded );
      },
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