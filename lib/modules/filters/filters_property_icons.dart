import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersPropertyIcons extends StatefulWidget {
  const FiltersPropertyIcons({Key? key}) : super(key: key);

  @override
  State<FiltersPropertyIcons> createState() => _FiltersPropertyIconsState();
}

class _FiltersPropertyIconsState extends State<FiltersPropertyIcons> {

  late List<String> _filtersPropertyHouseState;
  
  @override
  void initState() {
    super.initState();

    _filtersPropertyHouseState = Preferences.filterPropertyIcons;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 16.0 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), 
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: _filtersPropertyHouseState.contains('Detached') ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.home_outlined, size: 50.0, 
                  color: _filtersPropertyHouseState.contains('Detached') ? Colors.white : kPrimaryColor,
                ),
                const Text('DETACHED', style: TextStyle( color: Colors.transparent , fontSize: 14.0, ), ),
                Text('DETACHED', style: TextStyle( 
                  color: _filtersPropertyHouseState.contains('Detached') ?  Colors.white : kPrimaryColor , 
                  fontSize: 14.0, 
                ), ),
              ]
            ),
          ),
          onTap: () {
            setState(() {
              _filtersPropertyHouseState.contains('Detached') ? _filtersPropertyHouseState.remove('Detached') : _filtersPropertyHouseState.add('Detached');
              Preferences.filterPropertyIcons = _filtersPropertyHouseState;
            });
          },
        ), 
        const SizedBox( width: 6.0,),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 14.0 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), 
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: _filtersPropertyHouseState.contains('Semi-Detached') ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Icon(
                      Icons.home_outlined, size: 50.0, 
                      color: _filtersPropertyHouseState.contains('Semi-Detached') ? Colors.white : kPrimaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only( left: 25.0),
                      child: Icon(
                      Icons.home_outlined, size: 50.0, 
                      color: _filtersPropertyHouseState.contains('Semi-Detached') ? Colors.white : kPrimaryColor,
                    ),
                    )
                  ],
                ),
                Text('SEMI \n DETACHED', style: TextStyle( 
                  color: _filtersPropertyHouseState.contains('Semi-Detached') ? Colors.white : kPrimaryColor , 
                  fontSize: 14.0, 
                ), textAlign: TextAlign.center,)
              ]
            ),
          ),
          onTap: () {
            setState(() {
              _filtersPropertyHouseState.contains('Semi-Detached') ? _filtersPropertyHouseState.remove('Semi-Detached') : _filtersPropertyHouseState.add('Semi-Detached');
              Preferences.filterPropertyIcons = _filtersPropertyHouseState;
            });
          },
        ), 
        const SizedBox( width: 6.0,),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 8.0 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), 
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: _filtersPropertyHouseState.contains('Att/Row/Twnhouse') ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.holiday_village_outlined, size: 50.0, 
                  color: _filtersPropertyHouseState.contains('Att/Row/Twnhouse') ? Colors.white : kPrimaryColor,
                ),
                const Text('TOWNHOUSE', style: TextStyle( color: Colors.transparent , fontSize: 14.0, ), ),
                Text('TOWNHOUSE', style: TextStyle( 
                  color: _filtersPropertyHouseState.contains('Att/Row/Twnhouse') ? Colors.white : kPrimaryColor , 
                  fontSize: 14.0, 
                ), )
              ]
            ),
          ),
          onTap: () {
            setState(() {
              _filtersPropertyHouseState.contains('Att/Row/Twnhouse') ? _filtersPropertyHouseState.remove('Att/Row/Twnhouse') : _filtersPropertyHouseState.add('Att/Row/Twnhouse');       
              Preferences.filterPropertyIcons = _filtersPropertyHouseState;
            });
          },
        ),              
      ],
    );
  }
}
