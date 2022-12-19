
import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersPriceSlider extends StatefulWidget {
  const FiltersPriceSlider({Key? key}) : super(key: key);

  @override
  State<FiltersPriceSlider> createState() => _FiltersPriceSliderState();
}

class _FiltersPriceSliderState extends State<FiltersPriceSlider> {
  
  int indexTop = 0;
  int indexValue = 0;
  //double valueBottom = 20;

  late double _filterPriceRangeStart;
  late double _filterPriceRangeEnd;
  late RangeValues selectedRange;
  late String maxUnlimited;


  @override
  void initState() {
    super.initState();
    _filterPriceRangeStart = 9.0;
    _filterPriceRangeEnd = 28.0;
    selectedRange = RangeValues(_filterPriceRangeStart, _filterPriceRangeEnd);
    //RangeValues _currentRangeValues = const RangeValues(40, 80);

    if (_filterPriceRangeEnd < 4800000) {
      maxUnlimited = '\$${_filterPriceRangeEnd.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more';
    } else {
      maxUnlimited = 'max';
    }

    //maxUnlimited = '\$${_filterPriceRangeEnd.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more';
  }


  @override
  Widget build(BuildContext context) => SliderTheme(
        data: const SliderThemeData(
          /// ticks in between
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
            //buildSliderSideLabel(),
            /* const SizedBox(height: 16),
            buildSliderTopLabel(),
            const SizedBox(height: 16), */
            buildRangeSlider()
          ],
        ),
      );

  /* Widget buildSliderSideLabel() {
    final double min = 20;
    final double max = 80;
    final divisions = 4;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          buildSideLabel(min),
          Expanded(
            child: Slider(
              value: valueBottom,
              min: min,
              max: max,
              divisions: divisions,
              label: valueBottom.round().toString(),
              onChanged: (value) => setState(() => this.valueBottom = value),
            ),
          ),
          buildSideLabel(max),
        ],
      ),
    );
  } */

  /* Widget buildSliderTopLabel() {
    final labels = ['0', '100000', '150000', '200000', '250000', '300000', '350000', '400000', '450000', '500000', '550000', '600000', '650000', '700000', '750000', '800000', '850000', '900000', '950000', 
    '1000000', '1200000', '1300000', '1400000', '1500000', '1600000', '1700000', '1800000', '1900000', 
    '2000000', '2250000', '2500000', '2750000', '3000000', '3250000', '3500000', '3750000', '4000000', '4250000','4500000','4750000',
    '5000000 +'];
    double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;

    return Column(
      children: [
        /* Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Utils.modelBuilder(
              labels,
              (index, label) {
                final selectedColor = Colors.black;
                final unselectedColor = Colors.black.withOpacity(0.3);
                final isSelected = index <= indexTop;
                final color = isSelected ? selectedColor : unselectedColor;

                return buildLabel(label: label.toString(), color: color, width: 30);
              },
            ),
          ),
        ), */
        Slider(
          value: indexTop.toDouble(),
          min: min,
          max: max,
          divisions: divisions,
          // label: labels[indexTop],
          onChanged: (value) => setState(() => indexTop = value.toInt()),
        ),
      ],
    );
  }
 */


  Widget buildRangeSlider() {
    final labels = ['0', '100000', '150000', '200000', '250000', '300000', '350000', '400000', '450000', '500000', '550000', '600000', '650000', '700000', '750000', '800000', '850000', '900000', '950000', 
    '1000000', '1200000', '1300000', '1400000', '1500000', '1600000', '1700000', '1800000', '1900000', 
    '2000000', '2250000', '2500000', '2750000', '3000000', '3250000', '3500000', '3750000', '4000000', '4250000','4500000','4750000',
    '5000000'];
    double min = 0;
    double max = 40;
    //final double max = labels.length - 1.0;
    final divisions = labels.length - 1;


    return Column(
      children: [
        /* Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Utils.modelBuilder(
              labels,
              (index, label) {
                final selectedColor = Colors.black;
                final unselectedColor = Colors.black.withOpacity(0.3);
                final isSelected = index <= indexTop;
                final color = isSelected ? selectedColor : unselectedColor;

                return buildLabel(label: label.toString(), color: color, width: 30);
              },
            ),
          ),
        ), */

        const SizedBox(height: 24.0),
        const Text('PRICE RANGE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
        const SizedBox(height: 12.0,),


        Padding(
          padding: const EdgeInsets.symmetric( vertical: 0.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* Text(
                '\$${selectedRange.start.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ), */
        
              Text(
                '\$${labels[selectedRange.start.toInt()].replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}  \n or more', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor ),
              ),
        
              /* Text(
                '\$${labels[selectedRange.end.toInt()].replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} \n or more', 
                //maxUnlimited,
                textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kPrimaryColor, ),
              ), */
        
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
          // label: labels[indexTop],
          onChanged: (RangeValues values) {
            setState(() {
              selectedRange = values;
              //print(selectedRange);
            });
          } 
        ),

        const SizedBox(height: 28.0),
      ],
    );
  }

  /* Widget buildLabel({
    required String label,
    required double width,
    required Color color,
  }) =>
      Container(
        width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ).copyWith(color: color),
        ),
      ); */

  /* Widget buildSideLabel(double value) => Container(
        width: 25,
        child: Text(
          value.round().toString(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ); */
}

/* class Utils {
  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
} */






