import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/filters/filters_style_house.dart';
import 'package:flutter_black_white/modules/filters/filters_basement.dart';
import 'package:flutter_black_white/modules/filters/filters_days_market.dart';
import 'package:flutter_black_white/modules/filters/filters_more_extra.dart';
import 'package:flutter_black_white/modules/filters/filters_parking.dart';
import 'package:flutter_black_white/modules/filters/filters_kitchens.dart';
import 'package:flutter_black_white/modules/filters/filters_style_condo.dart';
import 'package:flutter_black_white/modules/filters/filters_size.dart';
import 'package:flutter_black_white/modules/filters/filters_condo_fee.dart';
import 'package:flutter_black_white/modules/filters/filters_condo_extra.dart';

class FiltersMore extends StatefulWidget {
  const FiltersMore({Key? key}) : super(key: key);

  @override
  State<FiltersMore> createState() => _FiltersMoreState();
}

class _FiltersMoreState extends State<FiltersMore> {

  late List<bool> _openCloseIcons;
  List<Widget> bodyExpansionTile = [];

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
    ];
  }

  @override
  Widget build(BuildContext context) {

    final filterProvider = Provider.of<FilterProvider>( context );
    final currentFilter = filterProvider.filterProvider;

    if(currentFilter == "residential") {
      bodyExpansionTile = const <Widget>[
        FiltersStyleHouse(),
        FiltersBasement(),
        FiltersDaysMarket(),
        FiltersMoreExtra(),
        FiltersParking(),
        FiltersKitchens(),
        SizedBox( height: 24.0, ),
      ];
    } else if (currentFilter == "condo") {
      bodyExpansionTile = const <Widget>[
        FiltersStyleCondo(),
        FiltersDaysMarket(),
        FiltersSize(),
        FiltersCondoFee(),
        FiltersCondoExtra(),
        SizedBox( height: 24.0, ),
      ];
    }

    return SizedBox(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            const Divider( 
              thickness: 2.0, 
              color: kSecondaryColor, 
              indent: 24.0, 
              endIndent: 24.0, 
              height: 0,
            ),
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
              //childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              title: const Text('MORE FILTERS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
              trailing: Icon(
                _openCloseIcons[0] ? Icons.remove : Icons.add,
                color: kSecondaryColor,
              ),
              children: bodyExpansionTile,
              onExpansionChanged: (bool expanded) {
                setState(() => _openCloseIcons[0] = expanded );
              },
            ),            
          ],
        )
      ),
    );
  }
}
