import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';


class FiltersMoreExtra extends StatefulWidget {
  const FiltersMoreExtra({Key? key}) : super(key: key);

  @override
  State<FiltersMoreExtra> createState() => _FiltersMoreExtraState();
}

class _FiltersMoreExtraState extends State<FiltersMoreExtra> {

  late bool _selectedBt1;
  late bool _selectedBt2;

  @override
  void initState() {
    super.initState();

    _selectedBt1 = Preferences.getfiltersMaxOpenHouseDate();
    _selectedBt2 = Preferences.getfiltersIndexSwimmingPool().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 12.0),
          child: BlueDivider()
        ),
        Padding(
          padding: const EdgeInsets.symmetric( horizontal: 10.0, vertical: 14.0 ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: Text('OPEN HOUSE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _selectedBt1 ? Colors.white : kPrimaryColor ),),
                ), 
                labelPadding: const EdgeInsets.all(0.0),
                backgroundColor: const Color(0xFFFFFFFF),
                selectedColor: kPrimaryColor,
                shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
                side: const BorderSide( color: kPrimaryColor ),
                selected: _selectedBt1,
                onSelected: ( bool selected ) {
                  setState(() {
                    _selectedBt1 = selected;
                    Preferences.setfiltersMaxOpenHouseDate(selected);
                  });            
                },
              ),
              const SizedBox( width: 10.0, ),
              ChoiceChip(
                label: Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: Text('POOL', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _selectedBt2 ? Colors.white : kPrimaryColor ),),
                ), 
                labelPadding: const EdgeInsets.all(0.0),
                backgroundColor: const Color(0xFFFFFFFF),
                selectedColor: kPrimaryColor,
                shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
                side: const BorderSide( color: kPrimaryColor ),
                selected: _selectedBt2,
                onSelected: ( bool selected ) {
                  setState(() {
                    _selectedBt2 = selected;
                    _selectedBt2 ? Preferences.setfiltersIndexSwimmingPool(['Inground','Indoor','Abv Grnd']) : Preferences.setfiltersIndexSwimmingPool([]);
                  });            
                },
              ),              
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 12.0),
          child: BlueDivider()
        ), 
      ],
    );
  }
}
