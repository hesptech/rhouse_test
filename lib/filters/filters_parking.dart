import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';



class FiltersParking extends StatefulWidget {
  const FiltersParking({Key? key}) : super(key: key);

  @override
  State<FiltersParking> createState() => _FiltersParkingState();
}

class _FiltersParkingState extends State<FiltersParking> {

  late List<PropertiesParking> _propertiesParking;
  //late List<String> _filtersSearchParking;
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
    //_filtersSearchParking = [];
    _choiceIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB( 28.0, 28.0, 28.0, 14.0 ),
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
          //const Text('BATHROOMS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
          Wrap(
            children: propertiesParkingWidgets.toList(),
          ),
        ],
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
            child: Text(propertiesParking.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _choiceIndex == _propertiesParking.indexOf(propertiesParking) ? Colors.white : kPrimaryColor),),
          ), 
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _choiceIndex == _propertiesParking.indexOf(propertiesParking),
          onSelected: ( bool selected ) {
            setState(() {
              _choiceIndex = _propertiesParking.indexOf(propertiesParking) ;
              //selected ? _filtersSearchParking.add(propertiesParking.name) : _filtersSearchParking.removeWhere((String name) => name == propertiesParking.name);

            });
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