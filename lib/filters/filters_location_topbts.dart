import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';



class FiltersLocationTopbts extends StatefulWidget {
  const FiltersLocationTopbts({Key? key}) : super(key: key);

  @override
  State<FiltersLocationTopbts> createState() => _FiltersLocationTopbtsState();
}

class _FiltersLocationTopbtsState extends State<FiltersLocationTopbts> {

  late List<PropertiesTopbts> _propertiesTopbts;
  late List<String> _filtersTopbts;

  @override
  void initState() {
    super.initState();

    _propertiesTopbts = <PropertiesTopbts>[
      const PropertiesTopbts('TORONTO'),
      const PropertiesTopbts('Suburbs - Outskirts'),
    ];
    _filtersTopbts = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox( height: 1.0, ),
        Wrap(
          children: propertiesTopbtsWidgets.toList(),
        ),     

        //const SizedBox( height: 14.0, ),

        //Text('Prefs. filterRoomsLoggedOut: ${Preferences.filtersGtaWestLoggedOut}'),
        //Text('Prefs. filterRoomsLoggedIn: ${Preferences.filtersGtaWestLoggedIn}'),
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
            child: Text(propertiesTopbts.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersTopbts.contains(propertiesTopbts.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersTopbts.contains(propertiesTopbts.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersTopbts.add(propertiesTopbts.name) : _filtersTopbts.removeWhere((String name) => name == propertiesTopbts.name) ;
                //Preferences.filtersGtaWestLoggedOut = _filtersGtaWest;
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