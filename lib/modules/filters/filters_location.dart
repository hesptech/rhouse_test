import 'package:flutter/material.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';
import 'package:flutter_black_white/modules/filters/filters_location_topbts.dart';
import 'package:flutter_black_white/modules/filters/filters_tr_central.dart';
import 'package:flutter_black_white/modules/filters/filters_tr_east.dart';
import 'package:flutter_black_white/modules/filters/filters_tr_west.dart';
import 'package:flutter_black_white/modules/filters/filters_gta_west.dart';
import 'package:flutter_black_white/modules/filters/filters_gta_north.dart';
import 'package:flutter_black_white/modules/filters/filters_gta_east.dart';
import 'package:flutter_black_white/modules/filters/filters_other.dart';


class FiltersLocation extends StatefulWidget {
  const FiltersLocation({Key? key}) : super(key: key);

  @override
  State<FiltersLocation> createState() => _FiltersLocationState();
}

class _FiltersLocationState extends State<FiltersLocation> {


  late List<bool> _openCloseIcons;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
      false,
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
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              title: const Text('LOCATION', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
              trailing: Icon(
                _openCloseIcons[0] ? Icons.remove : Icons.add,
                color: kSecondaryColor,
              ),
              children: <Widget>[
                const FiltersLocationTopbts(),
                const SizedBox( height: 12.0, ),
                ExpansionTile(
                  title: const Text('Toronto more or specific location', style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.w500, ),),
                  trailing: Icon(
                    _openCloseIcons[4] ? Icons.remove : Icons.add,
                    color: kSecondaryColor,
                    size: 18.0,
                  ),
                  children: const [
                    FiltersTrCentral(),
                    BlueDivider(),
                    FiltersTrEast(),
                    BlueDivider(),
                    FiltersTrWest(),                  
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _openCloseIcons[4] = expanded );
                  },
                ),
                //const BlueDivider(),
                ExpansionTile(
                  title: const Text('Suburbs more or specific location', style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.w500, ),),
                  trailing: Icon(
                    _openCloseIcons[5] ? Icons.remove : Icons.add,
                    color: kSecondaryColor,
                    size: 18.0,
                  ),
                  children: const [
                    FiltersGtaWest(),
                    BlueDivider(),
                    FiltersGtaNorth(),
                    BlueDivider(),
                    FiltersGtaEast(),
                    BlueDivider(),
                    FiltersOther(),                    
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _openCloseIcons[5] = expanded );
                  },
                ),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => _openCloseIcons[0] = expanded );
                if (expanded == false) {
                  setState(() => _openCloseIcons[1] = false );
                  setState(() => _openCloseIcons[2] = false );
                  setState(() => _openCloseIcons[4] = false );
                  setState(() => _openCloseIcons[5] = false );
                }
              },              
            )
          ],
      )
      ),
    );
  }
}