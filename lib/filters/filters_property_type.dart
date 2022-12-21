import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/filters/filters_property_condo.dart';
import 'package:flutter_black_white/filters/filters_property_house.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersPropertyType extends StatefulWidget {
  const FiltersPropertyType({Key? key}) : super(key: key);

  @override
  State<FiltersPropertyType> createState() => _FiltersPropertyTypeState();
}

class _FiltersPropertyTypeState extends State<FiltersPropertyType> {

  late List<bool> _openCloseIcons;
  late List<Widget> bodyExpansionTile;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
      false,
      false,
      false,
    ]; 
  }

  @override
  Widget build(BuildContext context) {

    final filterProvider = Provider.of<FilterProvider>( context );
    final currentFilter = filterProvider.filterProvider;

    if(currentFilter == "residential") {
      bodyExpansionTile = [
        const FiltersPropertyHouse()
      ];
    } else if (currentFilter == "condo") {
      bodyExpansionTile = [
        const FiltersPropertyCondo()
      ];
    }

    return SizedBox(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              title: const Text('PROPERTY TYPE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
              trailing: Icon(
                _openCloseIcons[0] ? Icons.remove : Icons.add,
                color: kSecondaryColor,
              ),
              children: bodyExpansionTile,
              onExpansionChanged: (bool expanded) {
                setState(() => _openCloseIcons[0] = expanded );
                if (expanded == false) {
                  setState(() => _openCloseIcons[1] = false );
                  setState(() => _openCloseIcons[2] = false );
                }
              },
            ),            
          ],
        )
      ),
    );
  }
}
