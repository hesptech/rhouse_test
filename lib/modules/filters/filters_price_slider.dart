import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersPriceSlider extends StatefulWidget {
  const FiltersPriceSlider({Key? key}) : super(key: key);

  @override
  State<FiltersPriceSlider> createState() => _FiltersPriceSliderState();
}

class _FiltersPriceSliderState extends State<FiltersPriceSlider> {

  int indexTop = 0;
  int indexValue = 0;

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
  Widget build(BuildContext context) => SliderTheme(
    data: const SliderThemeData(
      thumbColor: kPrimaryColor,
      activeTrackColor: kPrimaryColor,
      inactiveTrackColor: kSecondaryColor,
      valueIndicatorColor: kPrimaryColor,
      activeTickMarkColor: Colors.transparent,
      inactiveTickMarkColor: Colors.transparent,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildRangeSlider()
      ],
    ),
  );


  Widget buildRangeSlider() {
    const labels = kLabels;
    double min = 0;
    double max = 40;
    final divisions = labels.length - 1;


    return Column(
      children: [
        const SizedBox(height: 24.0),
        const Text('PRICE RANGE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
        const SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric( vertical: 0.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
        
              Text(
                '\$${labels[selectedRange.start.toInt()].replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}  \n or more', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ),
        
              Text(selectedRange.end.toInt() < 40 ? 
              '\$${labels[selectedRange.end.toInt()].replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}  \n or more' : 
              'max', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ),
            ],
          ),
        ),

        RangeSlider(
          values: selectedRange,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: (RangeValues values) {
            setState(() {
              selectedRange = values;
            });
            Preferences.filterPriceRangeStart = selectedRange.start;
            Preferences.filterPriceRangeEnd = selectedRange.end;            
          } 
        ),

        const SizedBox(height: 14.0),
      ],
    );
  }
}
