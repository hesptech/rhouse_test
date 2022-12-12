import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';


class FiltersDaysMarket extends StatefulWidget {
  const FiltersDaysMarket({Key? key}) : super(key: key);

  @override
  State<FiltersDaysMarket> createState() => _FiltersDaysMarketState();
}

class _FiltersDaysMarketState extends State<FiltersDaysMarket> {

  late double _filterDaysStart;
  late double _filterDaysEnd;
  late RangeValues selectedRange;
  late String maxUnlimited = 'more than ${_filterDaysEnd.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more';


  //double sliderValue = 10;

  @override
  void initState() {
    super.initState();

    _filterDaysStart = Preferences.filterDaysMarketStart;
    _filterDaysEnd = Preferences.filterDaysMarketEnd;
    selectedRange = RangeValues(_filterDaysStart, _filterDaysEnd);

    if (_filterDaysEnd < 90) {
      maxUnlimited = 'max. ${_filterDaysEnd.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} day(s)';
    } else {
      maxUnlimited = 'more than ${_filterDaysEnd.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} days';
    }
    
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 12.0),
          child: BlueDivider()),
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('DAYS ON MARKET', style: TextStyle(fontSize: 18, color: kPrimaryColor),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric( vertical: 0.0, horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'min. ${selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} day(s)', 
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
          child: RangeSlider(
            values: selectedRange,
            max: 90,
            divisions: 90,
            labels: RangeLabels(
              selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
              selectedRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                selectedRange = values;
                if (values.end < 90) {
                  maxUnlimited = 'max. ${values.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} day(s)';
                } else {
                  maxUnlimited = 'more than ${values.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} days';
                }
                selectedRange = values;
              });
            Preferences.filterDaysMarketStart = selectedRange.start;
            Preferences.filterDaysMarketEnd = selectedRange.end;
            },
          ),
        ),
        const SizedBox( height: 6.0,),


        /* Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 24.0, 18.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('DAYS ON MARKET', style: TextStyle(fontSize: 18, color: kPrimaryColor),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${sliderValue.round().toString()} days', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ),
            ],
          ),
        ), */

        /* SliderTheme(
          data: const SliderThemeData(
            thumbColor: kPrimaryColor,
            activeTrackColor: kPrimaryColor,
            inactiveTrackColor: kSecondaryColor,
            valueIndicatorColor: kPrimaryColor,
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
          ),
          child: Slider(
            value: sliderValue,
            min: 1,
            max: 30, 
            divisions: 30,
            //activeColor: kPrimaryColor,
            //inactiveColor: kSecondaryColor,
            label: sliderValue.round().toString(),
            onChanged: (value) => setState(() => sliderValue = value) 
          ),
        ), */


        /* Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 24.0, 18.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('DAYS ON MARKET', style: TextStyle(fontSize: 18, color: kPrimaryColor),),
            ],
          ),
        ),
        //const SizedBox(height: 16.0,),
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} Day', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ),
              Text(
                '${selectedRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} Days\n or more', 
                textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: const SliderThemeData(
            thumbColor: kSecondaryColor,
            activeTrackColor: kPrimaryColor,
            inactiveTrackColor: kSecondaryColor,
          ), 
          child: RangeSlider(
            min: 0,
            max: 30,
            labels: RangeLabels('${selectedRange.start}', '${selectedRange.end}'),
            values: selectedRange,
            onChanged: (RangeValues newRange) {
              setState(() => selectedRange = newRange);
              Preferences.filterDaysMarketStart = selectedRange.start;
              Preferences.filterDaysMarketEnd = selectedRange.end;
            },
          ),
        ), 
        const SizedBox( height: 12.0,) */       
      ]
    );
  }
}