import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/providers/repliers_provider.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersStatusBt extends StatefulWidget {
  const FiltersStatusBt({super.key});

  @override
  State<FiltersStatusBt> createState() => _FiltersStatusBtState();
}

class _FiltersStatusBtState extends State<FiltersStatusBt> {
  @override
  Widget build(BuildContext context) {

    final filterProvider = Provider.of<FilterProvider>( context );
    final stateSaleSold = Provider.of<RepliersProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(7.0),
            width: 145.0,
            decoration: filterProvider.filtersStatusProperties.contains('A') 
            ?
            const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              color: kPrimaryColor,
              border: Border(
                left: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                top: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                right: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                bottom: BorderSide(
                color: kPrimaryColor,
                width: 2,
                )
              )
            )
            :
            const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              color: Colors.white,
              border: Border(
                left: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                top: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                right: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                bottom: BorderSide(
                color: kPrimaryColor,
                width: 2,
                )
              )
            )                
            ,
            child: filterProvider.filtersStatusProperties.contains('A')
            ?
            const Text(
              'FOR SALE', 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),              
            )
            :
            const Text(
              'FOR SALE', 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),              
            )                
            ,
          ),
          onTap: () {
            setState(() {
              if(filterProvider.filtersStatusProperties.contains('A')) {
                // null
              } else {
                filterProvider.filtersStatusProperties.add('A');
                filterProvider.filtersStatusProperties.remove('U');


                stateSaleSold.displayPageHouses = 1;
                stateSaleSold.displayPageCondo = 1;
                stateSaleSold.onDisplayHouses = [];
                stateSaleSold.onDisplayCondo = [];
                stateSaleSold.getDisplayHousesStatus(filterProvider.filtersStatusProperties);
                stateSaleSold.getDisplayCondoStatus(filterProvider.filtersStatusProperties);
              }
            });

            Preferences.filtersStatusProperties = filterProvider.filtersStatusProperties;
          },
        ),
        const SizedBox(width: 20.0,),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(7.0),
            width: 145.0,
            decoration: filterProvider.filtersStatusProperties.contains('U')
            ? 
            const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              color: kPrimaryColor,
              border: Border(
                left: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                top: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                right: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                bottom: BorderSide(
                color: kPrimaryColor,
                width: 2,
                )
              )
            )
            :
            const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              color: Colors.white,
              border: Border(
                left: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                top: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                right: BorderSide(
                color: kPrimaryColor,
                width: 2,
                ),
                bottom: BorderSide(
                color: kPrimaryColor,
                width: 2,
                )
              ),
            ),
            child: filterProvider.filtersStatusProperties.contains('U')
            ?
            const Text(
              'SOLD', 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),              
            )
            :
            const Text(
              'SOLD', 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),              
            )

          ),
          onTap: () {
            setState(() {

              if(filterProvider.filtersStatusProperties.contains('U')) {
                // null
              } else {
                filterProvider.filtersStatusProperties.add('U');
                filterProvider.filtersStatusProperties.remove('A');


                stateSaleSold.displayPageHouses = 1;
                stateSaleSold.displayPageCondo = 1;
                stateSaleSold.onDisplayHouses = [];
                stateSaleSold.onDisplayCondo = [];
                stateSaleSold.getDisplayHousesStatus(filterProvider.filtersStatusProperties);
                stateSaleSold.getDisplayCondoStatus(filterProvider.filtersStatusProperties);
              }
            });

            Preferences.filtersStatusProperties = filterProvider.filtersStatusProperties;
          },
        ),
      ],
    );
  }
}
