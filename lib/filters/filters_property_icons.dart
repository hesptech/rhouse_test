import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersPropertyIcons extends StatefulWidget {
  const FiltersPropertyIcons({Key? key}) : super(key: key);

  @override
  State<FiltersPropertyIcons> createState() => _FiltersPropertyIconsState();
}

class _FiltersPropertyIconsState extends State<FiltersPropertyIcons> {

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
              color: Preferences.filterPropertyIcons.contains('detached') ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.home_outlined, size: 50.0, 
                  color: Preferences.filterPropertyIcons.contains('detached') ? Colors.white : kPrimaryColor,
                ),
                const Text('DETACHED', style: TextStyle( color: Colors.transparent , fontSize: 14.0, ), ),
                Text('DETACHED', style: TextStyle( 
                  color: Preferences.filterPropertyIcons.contains('detached') ?  Colors.white : kPrimaryColor , 
                  fontSize: 14.0, 
                ), ),
              ]
            ),
          ),
          onTap: () {
            setState(() {
              Preferences.filterPropertyIcons.contains('detached') ? Preferences.filterPropertyIcons.remove('detached') : Preferences.filterPropertyIcons.add('detached');
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
              color: Preferences.filterPropertyIcons.contains('semidetached') ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Icon(
                      Icons.home_outlined, size: 50.0, 
                      color: Preferences.filterPropertyIcons.contains('semidetached') ? Colors.white : kPrimaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only( left: 25.0),
                      child: Icon(
                      Icons.home_outlined, size: 50.0, 
                      color: Preferences.filterPropertyIcons.contains('semidetached') ? Colors.white : kPrimaryColor,
                    ),
                    )
                  ],
                ),
                Text('SEMI \n DETACHED', style: TextStyle( 
                  color: Preferences.filterPropertyIcons.contains('semidetached') ? Colors.white : kPrimaryColor , 
                  fontSize: 14.0, 
                ), textAlign: TextAlign.center,)
              ]
            ),
          ),
          onTap: () {
            setState(() {
              Preferences.filterPropertyIcons.contains('semidetached') ? Preferences.filterPropertyIcons.remove('semidetached') : Preferences.filterPropertyIcons.add('semidetached');
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
              color: Preferences.filterPropertyIcons.contains('townhouse') ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.holiday_village_outlined, size: 50.0, 
                  color: Preferences.filterPropertyIcons.contains('townhouse') ? Colors.white : kPrimaryColor,
                ),
                const Text('TOWNHOUSE', style: TextStyle( color: Colors.transparent , fontSize: 14.0, ), ),
                Text('TOWNHOUSE', style: TextStyle( 
                  color: Preferences.filterPropertyIcons.contains('townhouse') ? Colors.white : kPrimaryColor , 
                  fontSize: 14.0, 
                ), )
              ]
            ),
          ),
          onTap: () {
            setState(() {
              Preferences.filterPropertyIcons.contains('townhouse') ? Preferences.filterPropertyIcons.remove('townhouse') : Preferences.filterPropertyIcons.add('townhouse');       
            });
          },
        ),              
      ],
    );
  }
}