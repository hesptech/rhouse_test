import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersClassIconBt extends StatefulWidget {
  const FiltersClassIconBt({Key? key}) : super(key: key);

  @override
  State<FiltersClassIconBt> createState() => _FiltersClassIconBtState();
}

class _FiltersClassIconBtState extends State<FiltersClassIconBt> {
  late String _filtersClassIconsBt;

  @override
  void initState() {
    super.initState();

    _filtersClassIconsBt = Preferences.filtersClassIconsBt;
  }

  @override
  Widget build(BuildContext context) {

    final filterProvider = Provider.of<FilterProvider>( context );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric( vertical: 15.0, horizontal: 25.0 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), 
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: _filtersClassIconsBt == 'residential' ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.home_outlined, size: 100.0, 
                  color: _filtersClassIconsBt == 'residential' ? Colors.white : kPrimaryColor,
                ),
                Text('HOUSE', style: TextStyle( color: _filtersClassIconsBt == 'residential' ? Colors.white : kPrimaryColor , fontSize: 18.0, fontWeight: FontWeight.w500 ), )
              ]
            ),
          ),
          onTap: () {
            _filtersClassIconsBt = "residential";
            filterProvider.filterProvider = "residential";

            setState(() {
              Preferences.filtersClassIconsBt = 'residential';
            });
          },
        ), 
        const SizedBox( width: 18.0,),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric( vertical: 15.0, horizontal: 25.0 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), 
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: _filtersClassIconsBt == 'condo' ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.apartment, size: 100.0, 
                  color: _filtersClassIconsBt == 'condo' ? Colors.white : kPrimaryColor,
                ),
                Text('CONDO', style: TextStyle( color: _filtersClassIconsBt == 'condo' ? Colors.white : kPrimaryColor , fontSize: 18.0, fontWeight: FontWeight.w500 ), )
              ]
            ),
          ),
          onTap: () {
            _filtersClassIconsBt = "condo";
            filterProvider.filterProvider = "condo";

            setState(() {
              Preferences.filtersClassIconsBt = 'condo';
            });
          },
        ),              
      ],
    );
  }
}
