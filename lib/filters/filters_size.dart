import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersSize extends StatefulWidget {
  const FiltersSize({Key? key}) : super(key: key);

  @override
  State<FiltersSize> createState() => _FiltersSizeState();
}

class _FiltersSizeState extends State<FiltersSize> {

  late double _filterSizesStart;
  late double _filterSizesEnd;
  late RangeValues selectedRange;
  late String maxUnlimited;

  @override
  void initState() {
    super.initState();

    _filterSizesStart = Preferences.filterSizeStart;
    _filterSizesEnd = Preferences.filterSizeEnd;
    selectedRange = RangeValues(_filterSizesStart, _filterSizesEnd);

    if (_filterSizesEnd < 3000) {
      maxUnlimited = 'max. ${_filterSizesEnd.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} sqft.';
    } else {
      maxUnlimited = 'more than ${_filterSizesEnd.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} sqft.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('SIZE', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold,),),
            ],
          ),
        ),
        //const SizedBox(height: 16.0,),
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'min. ${selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} sqft.', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ),
              Text(
                maxUnlimited, 
                textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor),
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
          ), 
          child: RangeSlider(
            values: selectedRange,
            min: 0.0,
            max: 3000.0,
            labels: RangeLabels(
              selectedRange.start.toStringAsFixed(0), 
              selectedRange.end.toStringAsFixed(0)
            ),
            onChanged: (RangeValues newRange) {
              setState(() {
                selectedRange = newRange;
                if (newRange.end < 3000) {
                  maxUnlimited = 'max. ${newRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} sqft.';
                } else {
                  maxUnlimited = 'more than ${newRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} sqft.';
                }
              }); 

              Preferences.filterSizeStart = selectedRange.start;
              Preferences.filterSizeEnd = selectedRange.end;
            },
          ),
        ),
        const SizedBox( height: 6.0,),
      ]
    ); 
  }
}