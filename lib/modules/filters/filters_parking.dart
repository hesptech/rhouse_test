import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersParking extends StatefulWidget {
  const FiltersParking({Key? key}) : super(key: key);

  @override
  State<FiltersParking> createState() => _FiltersParkingState();
}

class _FiltersParkingState extends State<FiltersParking> {

  late List<PropertiesParking> _propertiesParking;
  late int _choiceIndex;

  @override
  void initState() {
    super.initState();

    _propertiesParking = <PropertiesParking>[
      const PropertiesParking('Any'),
      const PropertiesParking('1+'),
      const PropertiesParking('2+'),
      const PropertiesParking('3+'),
      const PropertiesParking('4+'),
    ];
    _choiceIndex = Preferences.filtersNumParkingSpaces;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB( 28.0, 28.0, 28.0, 14.0 ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('PARKING', style: TextStyle(fontSize: 18,  color: kPrimaryColor),),
              ],
            ),
            Wrap(
              children: propertiesParkingWidgets.toList(),
            ),
          ],
        ),
      ),
    );
  }

  Iterable<Widget> get propertiesParkingWidgets sync* {
    for (PropertiesParking propertiesParking in _propertiesParking) {
      yield Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: ChoiceChip(
          label: Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(propertiesParking.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Preferences.filtersNumParkingSpaces == _propertiesParking.indexOf(propertiesParking) ? Colors.white : kPrimaryColor),),
          ), 
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: Preferences.filtersNumParkingSpaces == _propertiesParking.indexOf(propertiesParking),
          onSelected: ( bool selected ) {
            setState(() {
              _choiceIndex = _propertiesParking.indexOf(propertiesParking) ;
            });
            Preferences.filtersNumParkingSpaces = _choiceIndex;
          },
        ),
      );
    }
  }
}


class PropertiesParking {
  const PropertiesParking(this.name);
  final String name;
}