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

  @override
  void initState() {
    super.initState();
    _filterPriceRangeStart = Preferences.filterPriceRangeStart;
    _filterPriceRangeEnd = Preferences.filterPriceRangeEnd;
    selectedRange = RangeValues(_filterPriceRangeStart, _filterPriceRangeEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 28.0, horizontal: 21.0),
      child: Column(
        children: [
          const Text('PRICE RANGE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
          const SizedBox(height: 14.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or less', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ),
              Text(
                '\$${selectedRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more', 
                textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor, ),
              ),
            ],
          ),
          SliderTheme(
            data: const SliderThemeData(
              thumbColor: kSecondaryColor,
              activeTrackColor: kPrimaryColor,
              inactiveTrackColor: kSecondaryColor,
            ), 
            child: RangeSlider(
              min: 0,
              max: 5000000,
              labels: RangeLabels('${selectedRange.start}', '${selectedRange.end}'),
              values: selectedRange,
              onChanged: (RangeValues newRange) {
                setState(() => selectedRange = newRange);
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