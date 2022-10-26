import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

//import 'package:b_w0/helpers/shared_preferences.dart';


class FiltersBathrooms extends StatefulWidget {
  const FiltersBathrooms({Key? key}) : super(key: key);

  @override
  State<FiltersBathrooms> createState() => _FiltersBathroomsState();
}

class _FiltersBathroomsState extends State<FiltersBathrooms> {

  late List<PropertiesBaths> _propertiesBaths;
  late List<String> _filtersSearchBaths;
  late int _defaultChoiceIndex;

  @override
  void initState() {
    super.initState();

    _propertiesBaths = <PropertiesBaths>[
      const PropertiesBaths('1+'),
      const PropertiesBaths('2+'),
      const PropertiesBaths('3+'),
      const PropertiesBaths('4+'),
      //const PropertiesBaths('5+'),
    ];
    _filtersSearchBaths = [];
    _defaultChoiceIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB( 24.0, 14.0, 24.0, 28.0 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('MINIMUM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                      Text('BATHROOMS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                    ],
                  ),
                  Wrap(
                    children: propertiesBathsWidgets.toList(),
                  ),
                ],
              ),
            ),        
          ],
        )
      ),
    );
  }


  Iterable<Widget> get propertiesBathsWidgets sync* {
    for (PropertiesBaths propertiesBaths in _propertiesBaths) {
      yield Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: ChoiceChip(
          label: Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(propertiesBaths.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _defaultChoiceIndex == _propertiesBaths.indexOf(propertiesBaths) ? Colors.white : kPrimaryColor),),
          ), 
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _defaultChoiceIndex == _propertiesBaths.indexOf(propertiesBaths),
          onSelected: ( bool selected ) {
            setState(() {
              _defaultChoiceIndex = selected ? _propertiesBaths.indexOf(propertiesBaths) : 0 ;
              selected ? _filtersSearchBaths.add(propertiesBaths.name) : _filtersSearchBaths.removeWhere((String name) => name == propertiesBaths.name);

            });
          },
        ),
      );
    }
  }
}


class PropertiesBaths {
  const PropertiesBaths(this.name);
  final String name;
}