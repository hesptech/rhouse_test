import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersClassIconsBt extends StatefulWidget {
  const FiltersClassIconsBt({Key? key}) : super(key: key);

  @override
  State<FiltersClassIconsBt> createState() => _FiltersClassIconsBtState();
}

class _FiltersClassIconsBtState extends State<FiltersClassIconsBt> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric( vertical: 20.0, horizontal: 30.0 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), 
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: Preferences.filterClassIcons.contains('freehold') ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.home_outlined, size: 100.0, 
                  color: Preferences.filterClassIcons.contains('freehold') ? Colors.white : kPrimaryColor,
                ),
                Text('HOUSE', style: TextStyle( color: Preferences.filterClassIcons.contains('freehold') ? Colors.white : kPrimaryColor , fontSize: 18.0, fontWeight: FontWeight.w500 ), )
              ]
            ),
          ),
          onTap: () {
            setState(() {
              Preferences.filterClassIcons.contains('freehold') ? Preferences.filterClassIcons.remove('freehold') : Preferences.filterClassIcons.add('freehold') ; 
            });
          },
        ), 
        const SizedBox( width: 18.0,),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric( vertical: 20.0, horizontal: 30.0 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), 
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: Preferences.filterClassIcons.contains('condo') ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.apartment, size: 100.0, 
                  color: Preferences.filterClassIcons.contains('condo') ? Colors.white : kPrimaryColor,
                ),
                Text('CONDO', style: TextStyle( color: Preferences.filterClassIcons.contains('condo') ? Colors.white : kPrimaryColor , fontSize: 18.0, fontWeight: FontWeight.w500 ), )
              ]
            ),
          ),
          onTap: () {
            setState(() {
              Preferences.filterClassIcons.contains('condo') ? Preferences.filterClassIcons.remove('condo') : Preferences.filterClassIcons.add('condo') ;   
            });
          },
        ),              
      ],
    );
  }
}