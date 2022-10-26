import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';

import '../filters/filters_more_extra.dart';
import '../filters/filters_parking.dart';
import '../filters/filters_kitchens.dart';
import '../filters/filters_basement.dart';
import '../filters/filters_days_market.dart';

//import 'package:b_w0/helpers/shared_preferences.dart';
import '../filters/filters_style.dart';

class FiltersMore extends StatefulWidget {
  const FiltersMore({Key? key}) : super(key: key);

  @override
  State<FiltersMore> createState() => _FiltersMoreState();
}

class _FiltersMoreState extends State<FiltersMore> {

  late List<bool> _openCloseIcons;

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
            const Divider( 
              thickness: 2.0, 
              color: kSecondaryColor, 
              indent: 24.0, 
              endIndent: 24.0, 
              height: 0,
            ),
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              title: const Text('MORE FILTERS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
              trailing: Icon(
                _openCloseIcons[0] ? Icons.remove : Icons.add,
                color: kSecondaryColor,
              ),
              children: const <Widget>[
                FiltersStyle(),
                BlueDivider(),
                FiltersBasement(),
                BlueDivider(),
                FiltersDaysMarket(),
                BlueDivider(),
                FiltersMoreExtra(),
                BlueDivider(),
                FiltersParking(),
                FiltersKitchens(),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => _openCloseIcons[0] = expanded );
                if (expanded == false) {
                  //setState(() => _openCloseIcons[1] = false );
                  //setState(() => _openCloseIcons[2] = false );
                }
              },
            ),            
          ],
        )
      ),
    );
  }
}


class PropertiesStyle {
  const PropertiesStyle(this.name);
  final String name;
}