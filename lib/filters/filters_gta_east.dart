import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';


class FiltersGtaEast extends StatefulWidget {
  const FiltersGtaEast({Key? key}) : super(key: key);

  @override
  State<FiltersGtaEast> createState() => _FiltersGtaEastState();
}

class _FiltersGtaEastState extends State<FiltersGtaEast> {

  late List<bool> _openCloseIcons;
  late List<PropertiesGtaEast> _propertiesGtaEast;
  late List<PropertiesGtaEastOther> _propertiesGtaEastOther;
  late List<String> _filtersGtaEast;

  //bool citySelectAllGtaEast = Preferences.filtersGtaEastLoggedOut.length == 4;
  bool citySelectAll = false;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
    ];

    _propertiesGtaEast = <PropertiesGtaEast>[
      const PropertiesGtaEast('Scarbough'),
      const PropertiesGtaEast('Pickering'),
      const PropertiesGtaEast('Ajax'),
      const PropertiesGtaEast('Whitby'),
      const PropertiesGtaEast('Oshawa'),
    ];
    _propertiesGtaEastOther = <PropertiesGtaEastOther>[
      const PropertiesGtaEastOther('Clarington'),
      const PropertiesGtaEastOther('Uxbridge'),
      const PropertiesGtaEastOther('Scugog'),
      const PropertiesGtaEastOther('Brock'),
    ];
    _filtersGtaEast = [];
  }

  @override
  Widget build(BuildContext context) {

    return 
      ExpansionTile(
        title: const Text('GTA East', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
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
                    _filtersGtaEast.clear() ;
                    if(citySelectAll) {
                      citySelectAll = false;
                    } else {
                      citySelectAll = true;
                      for (var element in _propertiesGtaEast) {
                        _filtersGtaEast.add(element.name) ;
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
            children: propertiesGtaEastWidgets.toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox( width: 16.0, height: 42.0,),
              Text('Other', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ), textAlign: TextAlign.start, ),
            ],
          ),
          Wrap(
            children: propertiesGtaEastOtherWidgets.toList(),
          ),
          const SizedBox( height: 16.0,),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[0] = expanded );
        },
      );
  }

  Iterable<Widget> get propertiesGtaEastWidgets sync* {
    for (PropertiesGtaEast propertiesGtaEast in _propertiesGtaEast) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesGtaEast.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersGtaEast.contains(propertiesGtaEast.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersGtaEast.contains(propertiesGtaEast.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersGtaEast.add(propertiesGtaEast.name) : _filtersGtaEast.removeWhere((String name) => name == propertiesGtaEast.name) ;
                //Preferences.filtersGtaEastLoggedOut = _filtersGtaEast;
            });            
          },
        )
      );
    }
  }

  Iterable<Widget> get propertiesGtaEastOtherWidgets sync* {
    for (PropertiesGtaEastOther propertiesGtaEastOther in _propertiesGtaEastOther) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesGtaEastOther.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersGtaEast.contains(propertiesGtaEastOther.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersGtaEast.contains(propertiesGtaEastOther.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersGtaEast.add(propertiesGtaEastOther.name) : _filtersGtaEast.removeWhere((String name) => name == propertiesGtaEastOther.name) ;
                //Preferences.filtersGtaEastLoggedOut = _filtersGtaEast;
            });            
          },
        )
      );
    }
  }
}


class PropertiesGtaEast {
  const PropertiesGtaEast(this.name);
  final String name;
}

class PropertiesGtaEastOther {
  const PropertiesGtaEastOther(this.name);
  final String name;
}