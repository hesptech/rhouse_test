import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersPriceRange extends StatefulWidget {
  const FiltersPriceRange({Key? key}) : super(key: key);

  @override
  State<FiltersPriceRange> createState() => _FiltersPriceRangeState();
}

class _FiltersPriceRangeState extends State<FiltersPriceRange> {

  late double _filterPriceRangeStart;
  late double _filterPriceRangeEnd;
  late RangeValues selectedRange;
  //RangeValues _currentRangeValues = const RangeValues(40, 80);
  late String maxUnlimited = '\$${_filterPriceRangeEnd.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more';

  @override
  void initState() {
    super.initState();
    _filterPriceRangeStart = Preferences.filterPriceRangeStart;
    _filterPriceRangeEnd = Preferences.filterPriceRangeEnd;
    selectedRange = RangeValues(_filterPriceRangeStart, _filterPriceRangeEnd);
    //RangeValues _currentRangeValues = const RangeValues(40, 80);

    if (_filterPriceRangeEnd < 4800000) {
      maxUnlimited = '\$${_filterPriceRangeEnd.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or less';
    } else {
      maxUnlimited = 'max';
    }

    //maxUnlimited = '\$${_filterPriceRangeEnd.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 28.0, horizontal: 0.0),
      child: Column(
        children: [
          const Text('PRICE RANGE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
          const SizedBox(height: 14.0,),
          Padding(
            padding: const EdgeInsets.symmetric( vertical: 0.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more', 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
                ),
                Text(
                  //'\$${selectedRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more', 
                  maxUnlimited,
                  textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor, ),
                ),
              ],
            ),
          ),
          SliderTheme(
            data: const SliderThemeData(
              thumbColor: kPrimaryColor,
              activeTrackColor: kPrimaryColor,
              inactiveTrackColor: kSecondaryColor,
            valueIndicatorColor: kPrimaryColor,
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
            ), 
            /* child: RangeSlider(
              //min: 0,
              max: 5000000,
              divisions: 1000000,
              labels: RangeLabels('${selectedRange.start}', '${selectedRange.end}'),
              values: selectedRange,
              onChanged: (RangeValues newRange) {
                
                //setState(() => selectedRange = newRange);
                setState(() {
                  if (newRange.end < 4800000) {
                    maxUnlimited = '\$${newRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or less';
                  } else {
                    maxUnlimited = 'max';
                  }
                  selectedRange = newRange;
                });
                Preferences.filterPriceRangeStart = selectedRange.start;
                Preferences.filterPriceRangeEnd = selectedRange.end;
              },
            ), */

            child: RangeSlider(
              values: selectedRange,
              max: 5000000,
              divisions: 25,
              labels: RangeLabels(
                selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                selectedRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  selectedRange = values;
                  if (values.end < 4800000) {
                    maxUnlimited = '\$${values.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or less';
                  } else {
                    maxUnlimited = 'max';
                  }
                  selectedRange = values;
                });
                Preferences.filterPriceRangeStart = selectedRange.start;
                Preferences.filterPriceRangeEnd = selectedRange.end;
              },
            ),
          ),
        ],
      ),
    );
  }
}