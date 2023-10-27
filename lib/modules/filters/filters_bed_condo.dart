import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersBedCondo extends StatefulWidget {
  const FiltersBedCondo({Key? key}) : super(key: key);

  @override
  State<FiltersBedCondo> createState() => _FiltersBedCondoState();
}

class _FiltersBedCondoState extends State<FiltersBedCondo> {

  late List<PropertiesBedCondo> _propertiesBedCondo;
  late int _choiceIndex;
  late bool _den;


  @override
  void initState() {
    super.initState();
    _propertiesBedCondo = <PropertiesBedCondo>[
      const PropertiesBedCondo('0+'),
      const PropertiesBedCondo('1+'),
      const PropertiesBedCondo('2+'),
      const PropertiesBedCondo('3+'),
    ];
    _choiceIndex = Preferences.filtersBedCondo;
    if (Preferences.filtersDen == 'N') {
      _den = false;
    } else {
      _den = true;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB( 24.0, 28.0, 24.0, 0.0 ),
              child: Wrap(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('MINIMUM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                      Text('BEDROOMS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                    ],
                  ),
                  Row(
                    children: [
                      Wrap(
                        children: propertiesBedCondoWidgets.toList(),
                      ),
                      ChoiceChip(
                        label: Container(
                          width: 30,
                          alignment: Alignment.center,
                          child: Text('DEN', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: _den ? Colors.white : kPrimaryColor  ), ),
                        ), 
                        labelPadding: const EdgeInsets.all(0.0),
                        backgroundColor: const Color(0xFFFFFFFF),
                        selectedColor: kPrimaryColor,
                        shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
                        side: const BorderSide( color: kPrimaryColor ),
                        selected: _den,
                        onSelected: ( bool selected ) {
                          setState(() {
                            _den = selected;
                          });
                          Preferences.filtersDen = _den ? 'Y' : 'N';
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),        
          ],
        )
      ),
    );
  }


  Iterable<Widget> get propertiesBedCondoWidgets sync* {
    for (PropertiesBedCondo propertiesBedCondo in _propertiesBedCondo) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 0.0 ),
        child: ChoiceChip(
          label: Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(propertiesBedCondo.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Preferences.filtersBedCondo == _propertiesBedCondo.indexOf(propertiesBedCondo) ? Colors.white : kPrimaryColor ), ),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: Preferences.filtersBedCondo == _propertiesBedCondo.indexOf(propertiesBedCondo),
          onSelected: ( bool selected ) {
            setState(() {
              _choiceIndex = _propertiesBedCondo.indexOf(propertiesBedCondo);
            });
            Preferences.filtersBedCondo = _choiceIndex;
          },
        )
      );
    }
  }
}


class PropertiesBedCondo {
  const PropertiesBedCondo(this.name);
  final String name;
}