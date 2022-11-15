import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersCondoExtra extends StatefulWidget {
  const FiltersCondoExtra({Key? key}) : super(key: key);

  @override
  State<FiltersCondoExtra> createState() => _FiltersCondoExtraState();
}

class _FiltersCondoExtraState extends State<FiltersCondoExtra> {

  late List<PropertiesCondoExtra> _propertiesCondoExtra;
  late List<String> _filtersCondoExtra;

  @override
  void initState() {
    super.initState();
    
    _propertiesCondoExtra = <PropertiesCondoExtra>[
      const PropertiesCondoExtra('Concierge'),
      const PropertiesCondoExtra('Gym'),
      const PropertiesCondoExtra('Indoor Pool'),
      const PropertiesCondoExtra('Outdoor Pool'),
      const PropertiesCondoExtra('Visitor Parking'),
      const PropertiesCondoExtra('BBQ Allowed'),
      const PropertiesCondoExtra('Guest Suites'),
      const PropertiesCondoExtra('Roof Top Deck/Garden'),
      const PropertiesCondoExtra('Squash/Racket Court'),
      const PropertiesCondoExtra('Tennis Court'),
    ];
    _filtersCondoExtra = Preferences.filtersCondoExtra;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 12.0, ),
      child: Wrap(
          children: propertiesStyleCondoWidgets.toList(),
        ),
    )
    ;    
  }

  Iterable<Widget> get propertiesStyleCondoWidgets sync* {
    for (PropertiesCondoExtra propertiesStyle in _propertiesCondoExtra) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 5.0 ),
        child: ChoiceChip(
          label: Container(
            width: 160,
            alignment: Alignment.center,
            child: Text(propertiesStyle.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersCondoExtra.contains(propertiesStyle.name) ? Colors.white : kPrimaryColor),),
          ),
          labelPadding: const EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFFFFFFFF),
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersCondoExtra.contains(propertiesStyle.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersCondoExtra.add(propertiesStyle.name) : _filtersCondoExtra.removeWhere((String name) => name == propertiesStyle.name) ;
                Preferences.filtersCondoExtra = _filtersCondoExtra;
            });            
          },
        )
      );
    }
  }
}


class PropertiesCondoExtra {
  const PropertiesCondoExtra(this.name);
  final String name;
}