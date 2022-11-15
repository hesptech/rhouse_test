import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersCondoFee extends StatefulWidget {
  const FiltersCondoFee({Key? key}) : super(key: key);

  @override
  State<FiltersCondoFee> createState() => _FiltersCondoFeeState();
}

class _FiltersCondoFeeState extends State<FiltersCondoFee> {

  late double _filterCondoFeeStart;
  late double _filterCondoFeeEnd;
  late RangeValues selectedRange;

  @override
  void initState() {
    super.initState();

    _filterCondoFeeStart = Preferences.filterCondoFeeStart;
    _filterCondoFeeEnd = Preferences.filterCondoFeeEnd;
    selectedRange = RangeValues(_filterCondoFeeStart, _filterCondoFeeEnd);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('CONDO FEE', style: TextStyle(fontSize: 18, color: kPrimaryColor),),
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
                '\$${selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} ', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ),
              Text(
                '\$${selectedRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more', 
                textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor),
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
            min: 0.0,
            max: 1500.0,
            labels: RangeLabels('${selectedRange.start}', '${selectedRange.end}'),
            values: selectedRange,
            onChanged: (RangeValues newRange) {
              setState(() => selectedRange = newRange);
              Preferences.filterCondoFeeStart = selectedRange.start;
              Preferences.filterCondoFeeEnd = selectedRange.end;
            },
          ),
        ), 
        const SizedBox( height: 12.0,)       
      ]
    );      
  }
}