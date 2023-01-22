import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersParkCondo extends StatefulWidget {
  const FiltersParkCondo({Key? key}) : super(key: key);

  @override
  State<FiltersParkCondo> createState() => _FiltersParkCondoState();
}

class _FiltersParkCondoState extends State<FiltersParkCondo> {

  late List<PropertiesParkCondo> _propertiesParkCondo;
  //late List<String> _filtersSearchParkCondo;
  late int _choiceIndex;

  @override
  void initState() {
    super.initState();

    _propertiesParkCondo = <PropertiesParkCondo>[
      const PropertiesParkCondo('YES'),
      const PropertiesParkCondo('NO'),
    ];
    //_filtersSearchParkCondo = [];
    _choiceIndex = Preferences.filtersNumParkingSpacesCondos - 1;
    print(Preferences.filtersNumParkingSpacesCondos);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB( 24.0, 14.0, 24.0, 28.0 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('PARKING', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
            ],
          ),
          //const Text('BATHROOMS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
          Wrap(
            children: propertiesParkCondoWidgets.toList(),
          ),
        ],
      ),
    );    
  }

  Iterable<Widget> get propertiesParkCondoWidgets sync* {
    for (PropertiesParkCondo propertiesParkCondo in _propertiesParkCondo) {
      yield Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: ChoiceChip(
          label: Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(propertiesParkCondo.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Preferences.filtersNumParkingSpacesCondos - 1 == _propertiesParkCondo.indexOf(propertiesParkCondo) ? Colors.white : kPrimaryColor),),
          ), 
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: Preferences.filtersNumParkingSpacesCondos - 1 == _propertiesParkCondo.indexOf(propertiesParkCondo),
          onSelected: ( bool selected ) {
            setState(() {
              _choiceIndex = _propertiesParkCondo.indexOf(propertiesParkCondo) ;
            });
            Preferences.filtersNumParkingSpacesCondos = _choiceIndex + 1;
            print(Preferences.filtersNumParkingSpacesCondos);
          },
        ),
      );
    }
  }
}


class PropertiesParkCondo {
  const PropertiesParkCondo(this.name);
  final String name;
}