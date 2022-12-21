import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class FiltersClassIconsBt extends StatefulWidget {
  const FiltersClassIconsBt({Key? key}) : super(key: key);

  @override
  State<FiltersClassIconsBt> createState() => _FiltersClassIconsBtState();
}

class _FiltersClassIconsBtState extends State<FiltersClassIconsBt> {

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
            padding: const EdgeInsets.symmetric( vertical: 20.0, horizontal: 30.0 ),
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
            padding: const EdgeInsets.symmetric( vertical: 20.0, horizontal: 30.0 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), 
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: _filtersClassIconsBt == '&class=condo' ? kPrimaryColor : Colors.white,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.apartment, size: 100.0, 
                  color: _filtersClassIconsBt == '&class=condo' ? Colors.white : kPrimaryColor,
                ),
                Text('CONDO', style: TextStyle( color: _filtersClassIconsBt == '&class=condo' ? Colors.white : kPrimaryColor , fontSize: 18.0, fontWeight: FontWeight.w500 ), )
              ]
            ),
          ),
          onTap: () {
            _filtersClassIconsBt = "&class=condo";
            filterProvider.filterProvider = "&class=condo";

            setState(() {
              Preferences.filtersClassIconsBt = '&class=condo';
            });
          },
        ),              
      ],
    );
  }
}