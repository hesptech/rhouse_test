import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersClassButtons extends StatefulWidget {
  const FiltersClassButtons({Key? key}) : super(key: key);

  @override
  State<FiltersClassButtons> createState() => _FiltersClassButtonsState();
}

class _FiltersClassButtonsState extends State<FiltersClassButtons> {

  late List<String> _filtersClassButtons;

  @override
  void initState() {
    super.initState();
    _filtersClassButtons = Preferences.filtersClassButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: Container(
            width: 120.0,
            alignment: Alignment.center,
            child: Text('HOUSES', style: TextStyle( color: _filtersClassButtons.contains('houses') ? Colors.white : kPrimaryColor),),
          ),
          backgroundColor: kBackgroundColor,
          selectedColor: _filtersClassButtons.contains('houses') ? kPrimaryColor : kBackgroundColor,
          selected: _filtersClassButtons.contains('houses'),
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(4))),
          side: const BorderSide( color: kPrimaryColor ),
          onSelected: ( bool selected ) {
            setState(() {
              selected ? _filtersClassButtons.add('houses') : _filtersClassButtons.removeWhere((String name) => name == 'houses') ;
              Preferences.filtersClassButtons = _filtersClassButtons;
            });            
          },
        ),
        const SizedBox( width: 8.0,),
        ChoiceChip(
          label: Container(
            width: 120.0,
            alignment: Alignment.center,
            child: Text('CONDOS', style: TextStyle( color: _filtersClassButtons.contains('condos') ? Colors.white : kPrimaryColor),),
          ),
          backgroundColor: kBackgroundColor,
          selectedColor: _filtersClassButtons.contains('condos') ? kPrimaryColor : kBackgroundColor,
          selected: _filtersClassButtons.contains('condos'),
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(4))),
          side: const BorderSide( color: kPrimaryColor ),
          onSelected: ( bool selected ) {
            setState(() {
              selected ? _filtersClassButtons.add('condos') : _filtersClassButtons.removeWhere((String name) => name == 'condos') ;
              Preferences.filtersClassButtons = _filtersClassButtons;
            });            
          },
        ),
        //Text('A: ${Preferences.filtersClassButtons}'),
        //Text('B: ${_filtersClassButtons.join(', ')}'),      
      ],
    );
  }
}