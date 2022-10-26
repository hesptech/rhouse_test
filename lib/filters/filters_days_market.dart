import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';



class FiltersDaysMarket extends StatefulWidget {
  const FiltersDaysMarket({Key? key}) : super(key: key);

  @override
  State<FiltersDaysMarket> createState() => _FiltersDaysMarketState();
}

class _FiltersDaysMarketState extends State<FiltersDaysMarket> {

  late List<bool> _openCloseIcons;
  late double _filterDaysStart;
  late double _filterDaysEnd;
  late RangeValues selectedRange;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
      false,
      false,
      false,
    ];

    _filterDaysStart = 1.0;
    _filterDaysEnd = 30.0;
    selectedRange = RangeValues(_filterDaysStart, _filterDaysEnd);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('DAYS ON MARKET', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, ),),
      trailing: Icon(
        _openCloseIcons[3] ? Icons.remove : Icons.add,
        color: kPrimaryColor,
        size: 18.0,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 14.0, ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} Day', 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, ),
              ),
              Text(
                '${selectedRange.end.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} Days\n or more', 
                textAlign: TextAlign.right, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, ),
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
              //Preferences.filterDaysStart = selectedRange.start;
              //Preferences.filterDaysEnd = selectedRange.end;
            },
          ),
        ),
        const SizedBox( height: 14.0, )    
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _openCloseIcons[3] = expanded );
      },
    );
  }
}