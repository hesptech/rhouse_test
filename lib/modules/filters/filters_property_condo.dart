import 'package:flutter/material.dart';

import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';

class FiltersPropertyCondo extends StatefulWidget {
  const FiltersPropertyCondo({Key? key}) : super(key: key);

  @override
  State<FiltersPropertyCondo> createState() => _FiltersPropertyCondoState();
}

class _FiltersPropertyCondoState extends State<FiltersPropertyCondo> {
  late List<String> _filtersPropertyCondoState;

  @override
  void initState() {
    super.initState();

    _filtersPropertyCondoState = Preferences.filterPropertyIconsCondo; 
  }

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
                  color: _filtersPropertyCondoState.contains('Condo Apt') ? kPrimaryColor : Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.business_outlined, size: 50.0, 
                      color: _filtersPropertyCondoState.contains('Condo Apt') ? Colors.white : kPrimaryColor,
                    ),
                    Text('CONDO \n APARTMENT', style: TextStyle( 
                      color: _filtersPropertyCondoState.contains('Condo Apt') ?  Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center, ),
                  ]
                ),
              ),
              onTap: () {
                setState(() {
                  _filtersPropertyCondoState.contains('Condo Apt') ? _filtersPropertyCondoState.remove('Condo Apt') : _filtersPropertyCondoState.add('Condo Apt');
                  Preferences.filterPropertyIconsCondo = _filtersPropertyCondoState;
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
                  color: _filtersPropertyCondoState.contains('Co-Op Apt') ? kPrimaryColor : Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.domain_add_outlined, size: 50.0, 
                      color: _filtersPropertyCondoState.contains('Co-Op Apt') ? Colors.white : kPrimaryColor,
                    ),
                    Text('CO-OP \n APARTMENT', style: TextStyle( 
                      color: _filtersPropertyCondoState.contains('Co-Op Apt') ? Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center,)
                  ]
                ),
              ),
              onTap: () {
                setState(() {
                  _filtersPropertyCondoState.contains('Co-Op Apt') ? _filtersPropertyCondoState.remove('Co-Op Apt') : _filtersPropertyCondoState.add('Co-Op Apt');
                  Preferences.filterPropertyIconsCondo = _filtersPropertyCondoState;
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
                  color: _filtersPropertyCondoState.contains('Condo Townhouse') ? kPrimaryColor : Colors.white,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.maps_home_work_outlined, size: 50.0, 
                      color: _filtersPropertyCondoState.contains('Condo Townhouse') ? Colors.white : kPrimaryColor,
                    ),
                    Text('CONDO \n TOWNHOUSE', style: TextStyle( 
                      color: _filtersPropertyCondoState.contains('Condo Townhouse') ? Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center, )
                  ]
                ),
              ),
              onTap: () {
                setState(() {
                  _filtersPropertyCondoState.contains('Condo Townhouse') ? _filtersPropertyCondoState.remove('Condo Townhouse') : _filtersPropertyCondoState.add('Condo Townhouse'); 
                  Preferences.filterPropertyIconsCondo = _filtersPropertyCondoState;      
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
                  color: _filtersPropertyCondoState.contains('Parking Space') ? kPrimaryColor : Colors.white,
                ),
                child: Column(
                  children: [
                    Text('OTHER', style: TextStyle( 
                      color: _filtersPropertyCondoState.contains('Parking Space') ?  Colors.white : kPrimaryColor , 
                      fontSize: 14.0, 
                    ), textAlign: TextAlign.center, ),
                  ]
                ),
              ),
              onTap: () {
                setState(() {
                  _filtersPropertyCondoState.contains('Parking Space') ? _filtersPropertyCondoState.remove('Parking Space') : _filtersPropertyCondoState.add('Parking Space');
                  _filtersPropertyCondoState.contains('Comm Element Condo') ? _filtersPropertyCondoState.remove('Comm Element Condo') : _filtersPropertyCondoState.add('Comm Element Condo');
                  Preferences.filterPropertyIconsCondo = _filtersPropertyCondoState;
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
