import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
//import 'package:b_w0/helpers/shared_preferences.dart';

class FiltersPropertyIcons extends StatefulWidget {
  const FiltersPropertyIcons({Key? key}) : super(key: key);

  @override
  State<FiltersPropertyIcons> createState() => _FiltersPropertyIconsState();
}

class _FiltersPropertyIconsState extends State<FiltersPropertyIcons> {

  bool imageOn1 = false;
  bool imageOn2 = false;
  bool imageOn3 = false;

  @override
  void initState() {
    super.initState();
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
              color: imageOn1 ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.home_outlined, size: 50.0, 
                  color: imageOn1 ? Colors.white : kPrimaryColor,
                ),
                const Text('DETACHED', style: TextStyle( color: Colors.transparent , fontSize: 14.0, ), ),
                Text('DETACHED', style: TextStyle( color: imageOn1 ? Colors.white : kPrimaryColor , fontSize: 14.0, ), ),
              ]
            ),
          ),
          onTap: () {
            setState(() {
              imageOn1 ? imageOn1 = false : imageOn1 = true;
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
              color: imageOn2 ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Icon(
                      Icons.home_outlined, size: 50.0, 
                      color: imageOn2 ? Colors.white : kPrimaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only( left: 25.0),
                      child: Icon(
                      Icons.home_outlined, size: 50.0, 
                      color: imageOn2 ? Colors.white : kPrimaryColor,
                    ),
                    )
                  ],
                ),
                Text('SEMI \n DETACHED', style: TextStyle( color: imageOn2 ? Colors.white : kPrimaryColor , fontSize: 14.0, ), textAlign: TextAlign.center,)
              ]
            ),
          ),
          onTap: () {
            setState(() {
              imageOn2 ? imageOn2 = false : imageOn2 = true ;
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
              color: imageOn3 ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.holiday_village_outlined, size: 50.0, 
                  color: imageOn3 ? Colors.white : kPrimaryColor,
                ),
                const Text('TOWNHOUSE', style: TextStyle( color: Colors.transparent , fontSize: 14.0, ), ),
                Text('TOWNHOUSE', style: TextStyle( color: imageOn3 ? Colors.white : kPrimaryColor , fontSize: 14.0, ), )
              ]
            ),
          ),
          onTap: () {
            setState(() {
              imageOn3 ? imageOn3 = false : imageOn3 = true ;       
            });
          },
        ),              
      ],
    );
  }
}