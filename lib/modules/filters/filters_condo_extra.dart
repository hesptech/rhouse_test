import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
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

  List<List<String>> indexAmmenities = [
    ['Concierge'],
    ['Gym'],
    ['Indoor Pool'],
    ['Outdoor Pool'],
    ['Visitor Parking'],
    ['Bbqs Allowed'],
    ['Guest Suites'],
    ['Rooftop Deck/Garden'],
    ['Squash/Racquet Court'],
    ['Tennis Court'],
  ];  

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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric( vertical: 0.0, ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric( vertical: 12.0, horizontal: 24.0 ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('AMENITIES', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold,),),
            ],
          ),
        ),
        Wrap(
          children: propertiesStyleCondoWidgets.toList(),
        ),                
      ],
    );   
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

                if(selected){
                  Provider.of<FilterProvider>(context, listen: false).filtersAmmenities = [...Provider.of<FilterProvider>(context, listen: false).filtersAmmenities,  ...indexAmmenities[_propertiesCondoExtra.indexOf(propertiesStyle)]];
                } else {
                  for(int i = 0; i < indexAmmenities[_propertiesCondoExtra.indexOf(propertiesStyle)].length; ++i){
                    if(Provider.of<FilterProvider>(context, listen: false).filtersAmmenities.contains(indexAmmenities[_propertiesCondoExtra.indexOf(propertiesStyle)][i])){
                      Provider.of<FilterProvider>(context, listen: false).filtersAmmenities.removeWhere((String name) => name == indexAmmenities[_propertiesCondoExtra.indexOf(propertiesStyle)][i]);
                    }
                  }                
                }
                Preferences.setfiltersIndexAmmenities(Provider.of<FilterProvider>(context, listen: false).filtersAmmenities);

                //print(Provider.of<FilterProvider>(context, listen: false).filtersAmmenities);
                //print(Preferences.filtersCondoExtra);
                //print(Preferences.getfiltersIndexAmmenities());
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