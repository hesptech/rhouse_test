import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersLocationTopbts extends StatefulWidget {
  const FiltersLocationTopbts({Key? key}) : super(key: key);

  @override
  State<FiltersLocationTopbts> createState() => _FiltersLocationTopbtsState();
}

class _FiltersLocationTopbtsState extends State<FiltersLocationTopbts> {

  late List<PropertiesTopbts> _propertiesTopbts;


  @override
  void initState() {
    super.initState();

    _propertiesTopbts = <PropertiesTopbts>[
      const PropertiesTopbts('TORONTO'),
      const PropertiesTopbts('Suburbs - Outskirts'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox( height: 1.0, ),
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
              Preferences.filtersLocationTopbts.contains(propertiesTopbts.name) ? Preferences.filtersLocationTopbts.remove(propertiesTopbts.name) : Preferences.filtersLocationTopbts.add(propertiesTopbts.name) ;  
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