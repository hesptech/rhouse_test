import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/filters/filters_property_condo.dart';
import 'package:flutter_black_white/modules/filters/filters_property_house.dart';

class FiltersPropertyType extends StatefulWidget {
  const FiltersPropertyType({Key? key}) : super(key: key);

  @override
  State<FiltersPropertyType> createState() => _FiltersPropertyTypeState();
}

class _FiltersPropertyTypeState extends State<FiltersPropertyType> {

  late List<bool> _openCloseIcons;
  List<Widget> bodyExpansionTile = [
        const FiltersPropertyHouse()
      ];

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

    return SizedBox(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            Consumer<FilterProvider>(
              builder: (context, currentFilter, child) => ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
                childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                title: const Text('PROPERTY TYPE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
                trailing: Icon(
                  _openCloseIcons[0] ? Icons.remove : Icons.add,
                  color: kSecondaryColor,
                ),
                children: currentFilter.filterProvider == "residential" ? [const FiltersPropertyHouse()] : [const FiltersPropertyCondo()],
                onExpansionChanged: (bool expanded) {
                  setState(() => _openCloseIcons[0] = expanded );
                  if (expanded == false) {
                    setState(() => _openCloseIcons[1] = false );
                    setState(() => _openCloseIcons[2] = false );
                  }
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}