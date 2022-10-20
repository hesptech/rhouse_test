import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersTrCentral extends StatefulWidget {
  const FiltersTrCentral({Key? key}) : super(key: key);

  @override
  State<FiltersTrCentral> createState() => _FiltersTrCentralState();
}

class _FiltersTrCentralState extends State<FiltersTrCentral> {

  late List<PropertiesTorontoCentral> _propertiesTorontoCentral;
  late List<String> _filtersTorontoCentral;

  //bool citySelectAllTorontoCentral = Preferences.filtersCityTorontoCentralLoggedOut.length == 4;
  bool citySelectAllTorontoCentral = false;

  @override
  void initState() {
    super.initState();

    _propertiesTorontoCentral = <PropertiesTorontoCentral>[
      const PropertiesTorontoCentral('Downtown Toronto'),
      const PropertiesTorontoCentral('Midtown Toronto'),
      const PropertiesTorontoCentral('Leaside'),
      const PropertiesTorontoCentral('Toronto New York'),
    ];
    _filtersTorontoCentral = [];
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
              //const Text('Toronto - Central', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),),
              const Text('Toronto Central', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
              TextButton(
                onPressed: () {
                  setState(() {
                    _filtersTorontoCentral.clear();
                    if(citySelectAllTorontoCentral) {
                      citySelectAllTorontoCentral = false;
                    } else {
                      citySelectAllTorontoCentral = true;
                      for (var element in _propertiesTorontoCentral) {
                        _filtersTorontoCentral.add(element.name);
                      } 
                    }
                    //Preferences.filtersTorontoCentralLoggedOut = _filtersTorontoCentral;                      
                  });
                },
                child: Text( citySelectAllTorontoCentral ? 'Unselect all' : 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
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
          children: propertiesTorontoCentralWidgets.toList(),
        ),
        //Text('Prefs. filterRoomsLoggedOut: ${Preferences.filtersTorontoCentralLoggedOut}'),
        //Text('Prefs. filterRoomsLoggedIn: ${Preferences.filtersTorontoCentralLoggedIn}'),
      ],
    );
  }


  Iterable<Widget> get propertiesTorontoCentralWidgets sync* {
    for (PropertiesTorontoCentral propertiesTorontoCentral in _propertiesTorontoCentral) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 160,
            alignment: Alignment.center,
            child: Text(propertiesTorontoCentral.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersTorontoCentral.contains(propertiesTorontoCentral.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersTorontoCentral.contains(propertiesTorontoCentral.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersTorontoCentral.add(propertiesTorontoCentral.name) : _filtersTorontoCentral.removeWhere((String name) => name == propertiesTorontoCentral.name) ;
                //Preferences.filtersTorontoCentralLoggedOut = _filtersTorontoCentral;
            });            
          },
        )
      );
    }
  }
}


class PropertiesTorontoCentral {
  const PropertiesTorontoCentral(this.name);
  final String name;
}