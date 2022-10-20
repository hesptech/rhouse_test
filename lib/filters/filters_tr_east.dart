import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersTrEast extends StatefulWidget {
  const FiltersTrEast({Key? key}) : super(key: key);

  @override
  State<FiltersTrEast> createState() => _FiltersTrEastState();
}

class _FiltersTrEastState extends State<FiltersTrEast> {

  late List<PropertiesTorontoEast> _propertiesTorontoEast;
  late List<String> _filtersTorontoEast;

  //bool citySelectAllTorontoEast = Preferences.filtersCityTorontoEastLoggedOut.length == 4;
  bool citySelectAllTorontoEast = false;

  @override
  void initState() {
    super.initState();

    _propertiesTorontoEast = <PropertiesTorontoEast>[
      const PropertiesTorontoEast('Danforth'),
      const PropertiesTorontoEast('Beaches'),
      const PropertiesTorontoEast('East York'),
      const PropertiesTorontoEast('Leslieville/Riverdale'),
      const PropertiesTorontoEast('Scarborough'),
    ];
    _filtersTorontoEast = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox( height: 1.0, ),
        const Divider( 
          thickness: 1.0, 
          color: kPrimaryColor, 
          indent: 12.0, 
          endIndent: 12.0, 
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              const Text('Toronto East', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
              TextButton(
                onPressed: () {
                  setState(() {
                    _filtersTorontoEast.clear();
                    if(citySelectAllTorontoEast) {
                      citySelectAllTorontoEast = false;
                    } else {
                      citySelectAllTorontoEast = true;
                      for (var element in _propertiesTorontoEast) {
                        _filtersTorontoEast.add(element.name);
                      } 
                    }
                    //Preferences.filtersTorontoEastLoggedOut = _filtersTorontoEast;                      
                  });
                },
                child: Text( citySelectAllTorontoEast ? 'Unselect all' : 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
              ),
            ],
          ),
        ),
        const SizedBox( height: 1.0, ),
        const Divider( 
          thickness: 1.0, 
          color: kPrimaryColor, 
          indent: 12.0, 
          endIndent: 12.0, 
          height: 0,
        ),
        const SizedBox( height: 14.0, ),        
        Wrap(
          children: propertiesTorontoEastWidgets.toList(),
        ),
        //Text('Prefs. filterRoomsLoggedOut: ${Preferences.filtersTorontoEastLoggedOut}'),
        //Text('Prefs. filterRoomsLoggedIn: ${Preferences.filtersTorontoEastLoggedIn}'),
      ],
    );    
  }


  Iterable<Widget> get propertiesTorontoEastWidgets sync* {
    for (PropertiesTorontoEast propertiesTorontoEast in _propertiesTorontoEast) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 160,
            alignment: Alignment.center,
            child: Text(propertiesTorontoEast.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersTorontoEast.contains(propertiesTorontoEast.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersTorontoEast.contains(propertiesTorontoEast.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersTorontoEast.add(propertiesTorontoEast.name) : _filtersTorontoEast.removeWhere((String name) => name == propertiesTorontoEast.name) ;
                //Preferences.filtersTorontoEastLoggedOut = _filtersTorontoEast;
            });            
          },
        )
      );
    }
  }
}


class PropertiesTorontoEast {
  const PropertiesTorontoEast(this.name);
  final String name;
}