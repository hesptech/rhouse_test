import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersClassIconsBt extends StatefulWidget {
  const FiltersClassIconsBt({Key? key}) : super(key: key);

  @override
  State<FiltersClassIconsBt> createState() => _FiltersClassIconsBtState();
}

class _FiltersClassIconsBtState extends State<FiltersClassIconsBt> {

  bool imageHouseOn = true;
  bool imageCondoOn = false;

  @override
  void initState() {
    super.initState();
    imageHouseOn = Preferences.filterIconBtHouse;
    imageCondoOn = Preferences.filterIconBtCondo;
  }

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
              color: imageHouseOn ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.home_outlined, size: 100.0, 
                  color: imageHouseOn ? Colors.white : kPrimaryColor,
                ),
                Text('HOUSE', style: TextStyle( color: imageHouseOn ? Colors.white : kPrimaryColor , fontSize: 18.0, fontWeight: FontWeight.w500 ), )
              ]
            ),
          ),
          onTap: () {
            setState(() {
              imageHouseOn = true;
              imageCondoOn = false;
              Preferences.filterIconBtHouse = imageHouseOn;
              Preferences.filterIconBtCondo = imageCondoOn;
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
              color: imageCondoOn ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.apartment, size: 100.0, 
                  color: imageCondoOn ? Colors.white : kPrimaryColor,
                ),
                Text('CONDO', style: TextStyle( color: imageCondoOn ? Colors.white : kPrimaryColor , fontSize: 18.0, fontWeight: FontWeight.w500 ), )
              ]
            ),
          ),
          onTap: () {
            setState(() {
              imageCondoOn = true;
              imageHouseOn = false;
              Preferences.filterIconBtHouse = imageHouseOn;
              Preferences.filterIconBtCondo = imageCondoOn;        
            });
          },
        ),              
      ],
    );
  }
}