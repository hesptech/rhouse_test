import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersTrCentral extends StatefulWidget {
  const FiltersTrCentral({Key? key}) : super(key: key);

  @override
  State<FiltersTrCentral> createState() => _FiltersTrCentralState();
}

class _FiltersTrCentralState extends State<FiltersTrCentral> {

  late List<bool> _openCloseIcons;
  late List<PropertiesTrCentral> _propertiesTrCentral;
  late List<String> _filtersTrCentral;

  //bool citySelectAllGtaCentral = Preferences.filtersTrCentralLoggedOut.length == 4;
  bool citySelectAllGtaCentral = false;


  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
      false,
      false,
      false,
      false,
    ]; 

    _propertiesTrCentral = <PropertiesTrCentral>[
      const PropertiesTrCentral('Downtown Toronto'),
      const PropertiesTrCentral('Midtown Toronto'),
      const PropertiesTrCentral('Leaside'),
      const PropertiesTrCentral('Toronto North York'),
    ];
    _filtersTrCentral = [];
  }

  @override
  Widget build(BuildContext context) {

    return 
      ExpansionTile(
        title: const Text('Toronto Central', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
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
                    _filtersTrCentral.clear();
                    if(citySelectAllGtaCentral) {
                      citySelectAllGtaCentral = false;
                    } else {
                      citySelectAllGtaCentral = true;
                      for (var element in _propertiesTrCentral) {
                        _filtersTrCentral.add(element.name);
                      } 
                    }
                    //Preferences.filtersTrCentralLoggedOut = _filtersTrCentral;                      
                  });
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size( 50.0, 30.0 ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //alignment: Alignment.centerLeft
                ),
                child: Text( citySelectAllGtaCentral ? 'Unselect all' : 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor, ),),
              ),
              const SizedBox( width: 28.0),
            ],
          ),
          Wrap(
            children: propertiesTrCentralWidgets.toList(),
          ),
          const SizedBox( height: 16.0,),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _openCloseIcons[0] = expanded );
        },
      );
  }


  Iterable<Widget> get propertiesTrCentralWidgets sync* {
    for (PropertiesTrCentral propertiesTrCentral in _propertiesTrCentral) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(propertiesTrCentral.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersTrCentral.contains(propertiesTrCentral.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersTrCentral.contains(propertiesTrCentral.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersTrCentral.add(propertiesTrCentral.name) : _filtersTrCentral.removeWhere((String name) => name == propertiesTrCentral.name) ;
                //Preferences.filtersTrCentralLoggedOut = _filtersTrCentral;
            });            
          },
        )
      );
    }
  }
}

class PropertiesTrCentral {
  const PropertiesTrCentral(this.name);
  final String name;
}