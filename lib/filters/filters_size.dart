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

  @override
  void initState() {
    super.initState();

    _filterSizesStart = Preferences.filterSizeStart;
    _filterSizesEnd = Preferences.filterSizeEnd;
    selectedRange = RangeValues(_filterSizesStart, _filterSizesEnd);
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
              Text('SIZE', style: TextStyle(fontSize: 18, color: kPrimaryColor),),
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
                '${selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} SQ FT', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ),
              Text(
                '${selectedRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} SQ FT\n or more', 
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
            max: 3000.0,
            labels: RangeLabels('${selectedRange.start}', '${selectedRange.end}'),
            values: selectedRange,
            onChanged: (RangeValues newRange) {
              setState(() => selectedRange = newRange);
              Preferences.filterSizeStart = selectedRange.start;
              Preferences.filterSizeEnd = selectedRange.end;
            },
          ),
        ),
        const SizedBox( height: 12.0,),
      ]
    ); 
  }
}