import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';



class FiltersBasement extends StatefulWidget {
  const FiltersBasement({Key? key}) : super(key: key);

  @override
  State<FiltersBasement> createState() => _FiltersBasementState();
}

class _FiltersBasementState extends State<FiltersBasement> {

  late List<bool> _openCloseIcons;
  late List<PropertiesBasement> _propertiesBasement;
  late List<String> _filtersBasement;

  //bool selectAllBasement = Preferences.filtersBasementLoggedOut.length == 4;
  bool selectAllBasement = false;

  List<List<String>> filterBasement = [
    ['Finished'],
    ['Unfinished'],
    ['Partiallyfinished'],
    ['Sep Entrance'],
  ];

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
      false,
      false,
      false,
    ];
    
    _propertiesBasement = <PropertiesBasement>[
      const PropertiesBasement('Finished'),
      const PropertiesBasement('Unfinished'),
      const PropertiesBasement('Partially finished'),
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
          _openCloseIcons[2] ? Icons.remove : Icons.add,
          //Icons.add,
          color: kPrimaryColor,
          size: 18.0,
        ),
        children: [
          Wrap(
            children: propertiesBasementWidgets.toList(),
          ),
          const SizedBox( height: 14.0, ),
          const Divider( 
            thickness: 1.0, 
            color: kPrimaryColor, 
            indent: 12.0, 
            endIndent: 12.0, 
            height: 0,
          ), 
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 10.0, vertical: 14.0 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ChoiceChip(
                  label: Container(
                    width: 160,
                    alignment: Alignment.center,
                    child: Text('Separate Entrance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersBasement.contains('Separate Entrance') ? Colors.white : kPrimaryColor),),
                  ), 
                  labelPadding: const EdgeInsets.all(0.0),
                  backgroundColor: const Color(0xFFFFFFFF),
                  selectedColor: kPrimaryColor,
                  shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
                  side: const BorderSide( color: kPrimaryColor ),
                  selected: _filtersBasement.contains('Separate Entrance'),
                  onSelected: ( bool selected ) {
                    setState(() {
                        selected ? _filtersBasement.add('Separate Entrance') : _filtersBasement.removeWhere((String name) => name == 'Separate Entrance') ;
                        //Preferences.filtersBasementLoggedOut = _filtersBasement;
                    });            
                  },
                ),
          
              ]
            ),
          )       
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[2] = expanded );
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
                //Preferences.filtersBasementLoggedOut = _filtersBasement;
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