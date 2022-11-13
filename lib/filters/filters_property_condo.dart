import 'package:flutter/material.dart';

import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';


class FiltersPropertyCondo extends StatefulWidget {
  const FiltersPropertyCondo({Key? key}) : super(key: key);

  @override
  State<FiltersPropertyCondo> createState() => _FiltersPropertyCondoState();
}

class _FiltersPropertyCondoState extends State<FiltersPropertyCondo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 10.0 ),
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
                      Icons.business_outlined, size: 50.0, 
                      color: Preferences.filterPropertyIcons.contains('detached') ? Colors.white : kPrimaryColor,
                    ),
                    Text('CONDO \n APARTMENT', style: TextStyle( 
                      color: Preferences.filterPropertyIcons.contains('detached') ?  Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center, ),
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
                padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 10.0 ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), 
                  border: Border.all(
                    color: kPrimaryColor,
                  ),
                  color: Preferences.filterPropertyIcons.contains('semidetached') ? kPrimaryColor : Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.domain_add_outlined, size: 50.0, 
                      color: Preferences.filterPropertyIcons.contains('semidetached') ? Colors.white : kPrimaryColor,
                    ),
                    Text('CO-OP \n APARTMENT', style: TextStyle( 
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
                      Icons.maps_home_work_outlined, size: 50.0, 
                      color: Preferences.filterPropertyIcons.contains('townhouse') ? Colors.white : kPrimaryColor,
                    ),
                    Text('CONDO \n TOWNHOUSE', style: TextStyle( 
                      color: Preferences.filterPropertyIcons.contains('townhouse') ? Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center, )
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
        ),
        const SizedBox( height: 6.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric( vertical: 24.0, horizontal: 28.0 ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), 
                  border: Border.all(
                    color: kPrimaryColor,
                  ),
                  color: Preferences.filterPropertyIcons.contains('detached') ? kPrimaryColor : Colors.white,
                ),
                child: Column(
                  children: [
                    Text('OTHER', style: TextStyle( 
                      color: Preferences.filterPropertyIcons.contains('detached') ?  Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center, ),
                  ]
                ),
              ),
              onTap: () {
                setState(() {
                  Preferences.filterPropertyIcons.contains('detached') ? Preferences.filterPropertyIcons.remove('detached') : Preferences.filterPropertyIcons.add('detached');
                });
              },
            ),                
          ],
        ),
        const SizedBox( height: 24.0,),         
      ],
    );    
  }
}