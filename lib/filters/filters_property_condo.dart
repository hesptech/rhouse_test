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
                  color: Preferences.filterPropertyIconsCondo.contains('Condo Apt') ? kPrimaryColor : Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.business_outlined, size: 50.0, 
                      color: Preferences.filterPropertyIconsCondo.contains('Condo Apt') ? Colors.white : kPrimaryColor,
                    ),
                    Text('CONDO \n APARTMENT', style: TextStyle( 
                      color: Preferences.filterPropertyIconsCondo.contains('Condo Apt') ?  Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center, ),
                  ]
                ),
              ),
              onTap: () {
                setState(() {
                  Preferences.filterPropertyIconsCondo.contains('Condo Apt') ? Preferences.filterPropertyIconsCondo.remove('Condo Apt') : Preferences.filterPropertyIconsCondo.add('Condo Apt');
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
                  color: Preferences.filterPropertyIconsCondo.contains('Co-Op Apt') ? kPrimaryColor : Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.domain_add_outlined, size: 50.0, 
                      color: Preferences.filterPropertyIconsCondo.contains('Co-Op Apt') ? Colors.white : kPrimaryColor,
                    ),
                    Text('CO-OP \n APARTMENT', style: TextStyle( 
                      color: Preferences.filterPropertyIconsCondo.contains('Co-Op Apt') ? Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center,)
                  ]
                ),
              ),
              onTap: () {
                setState(() {
                  Preferences.filterPropertyIconsCondo.contains('Co-Op Apt') ? Preferences.filterPropertyIconsCondo.remove('Co-Op Apt') : Preferences.filterPropertyIconsCondo.add('Co-Op Apt');
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
                  color: Preferences.filterPropertyIconsCondo.contains('Condo Townhouse') ? kPrimaryColor : Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.maps_home_work_outlined, size: 50.0, 
                      color: Preferences.filterPropertyIconsCondo.contains('Condo Townhouse') ? Colors.white : kPrimaryColor,
                    ),
                    Text('CONDO \n TOWNHOUSE', style: TextStyle( 
                      color: Preferences.filterPropertyIconsCondo.contains('Condo Townhouse') ? Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center, )
                  ]
                ),
              ),
              onTap: () {
                setState(() {
                  Preferences.filterPropertyIconsCondo.contains('Condo Townhouse') ? Preferences.filterPropertyIconsCondo.remove('Condo Townhouse') : Preferences.filterPropertyIconsCondo.add('Condo Townhouse');       
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
                  color: Preferences.filterPropertyIconsCondo.contains('Parking Space') ? kPrimaryColor : Colors.white,
                ),
                child: Column(
                  children: [
                    Text('OTHER', style: TextStyle( 
                      color: Preferences.filterPropertyIconsCondo.contains('Parking Space') ?  Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center, ),
                  ]
                ),
              ),
              onTap: () {
                setState(() {
                  Preferences.filterPropertyIconsCondo.contains('Parking Space') ? Preferences.filterPropertyIconsCondo.remove('Parking Space') : Preferences.filterPropertyIconsCondo.add('Parking Space');
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