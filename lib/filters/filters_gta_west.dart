import 'package:flutter/material.dart';

//import 'package:flutter_expansionpanel/helpers/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';

class FiltersGtaWest extends StatefulWidget {
  const FiltersGtaWest({Key? key}) : super(key: key);

  @override
  State<FiltersGtaWest> createState() => _FiltersGtaWestState();
}

class _FiltersGtaWestState extends State<FiltersGtaWest> {

  late List<bool> _openCloseIcons;
  late List<PropertiesGtaWest> _propertiesGtaWest;
  late List<PropertiesGtaWestOther> _propertiesGtaWestOther;
  late List<String> _filtersGtaWest;

  //bool citySelectAllGtaWest = Preferences.filtersGtaWestLoggedOut.length == 4;
  bool citySelectAll = false;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
    ];

    _propertiesGtaWest = <PropertiesGtaWest>[
      const PropertiesGtaWest('Etobicoke'),
      const PropertiesGtaWest('Mississauga'),
      const PropertiesGtaWest('Brampton'),
      const PropertiesGtaWest('Oakville'),
      const PropertiesGtaWest('Milton'),
      const PropertiesGtaWest('Burlington'),
    ];
    _propertiesGtaWestOther = <PropertiesGtaWestOther>[
      const PropertiesGtaWestOther('Halton Hills'),
      const PropertiesGtaWestOther('Caledon'),
    ];
    _filtersGtaWest = [];
  }

  @override
  Widget build(BuildContext context) {


    return 
      ExpansionTile(
        title: const Text('GTA West', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
        trailing: Icon(
          _openCloseIcons[0] ? Icons.remove : Icons.add,
          color: kPrimaryColor,
          size: 18.0,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _filtersGtaWest.clear() ;
                    if(citySelectAll) {
                      citySelectAll = false;
                    } else {
                      citySelectAll = true;
                      for (var element in _propertiesGtaWest) {
                        _filtersGtaWest.add(element.name) ;
                      }
                    }
                    //isLoggedIn ? Preferences.userFiltersTrEastLoggedIn = _filtersSearchTrEastLoggedIn : Preferences.userFiltersTrEast = _filtersSearchTrEast ;
                  });  
                }, 
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size( 50.0, 30.0 ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //alignment: Alignment.centerLeft
                ),
                child: Text(citySelectAll ? 'Unselect all' : 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
              ),
              const SizedBox( width: 28.0),
            ],
          ),
          Wrap(
            children: propertiesGtaWestWidgets.toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox( width: 16.0, height: 42.0,),
              Text('Other', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ), textAlign: TextAlign.start, ),
            ],
          ),
          Wrap(
            children: propertiesGtaWestOtherWidgets.toList(),
          ),
          const SizedBox( height: 16.0,),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[0] = expanded );
        },
      );
  }

  Iterable<Widget> get propertiesGtaWestWidgets sync* {
    for (PropertiesGtaWest propertiesGtaWest in _propertiesGtaWest) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesGtaWest.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersGtaWest.contains(propertiesGtaWest.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersGtaWest.contains(propertiesGtaWest.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersGtaWest.add(propertiesGtaWest.name) : _filtersGtaWest.removeWhere((String name) => name == propertiesGtaWest.name) ;
                //Preferences.filtersGtaWestLoggedOut = _filtersGtaWest;
            });            
          },
        )
      );
    }
  }

  Iterable<Widget> get propertiesGtaWestOtherWidgets sync* {
    for (PropertiesGtaWestOther propertiesGtaWestOther in _propertiesGtaWestOther) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0, ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesGtaWestOther.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersGtaWest.contains(propertiesGtaWestOther.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersGtaWest.contains(propertiesGtaWestOther.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersGtaWest.add(propertiesGtaWestOther.name) : _filtersGtaWest.removeWhere((String name) => name == propertiesGtaWestOther.name) ;
                //Preferences.filtersGtaWestLoggedOut = _filtersGtaWest;
            });            
          },        
        ),
      );
    }
  }
}


class PropertiesGtaWest {
  const PropertiesGtaWest(this.name);
  final String name;
}

class PropertiesGtaWestOther {
  const PropertiesGtaWestOther(this.name);
  final String name;
}