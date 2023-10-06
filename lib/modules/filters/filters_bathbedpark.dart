import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:flutter_black_white/filters/filters.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/modules/filters/filters_bed_condo.dart';
import 'package:flutter_black_white/modules/filters/filters_bedrooms.dart';
import 'package:flutter_black_white/modules/filters/filters_bathrooms.dart';
//import 'package:flutter_black_white/modules/filters/filters_park_condo.dart';


class FiltersBathbedpark extends StatefulWidget {
  const FiltersBathbedpark({Key? key}) : super(key: key);

  @override
  State<FiltersBathbedpark> createState() => _FiltersBathbedparkState();
}

class _FiltersBathbedparkState extends State<FiltersBathbedpark> {

  List<Widget> filtersBathBedPark = [];

  @override
  Widget build(BuildContext context) {

    final filterProvider = Provider.of<FilterProvider>( context );
    final currentFilter = filterProvider.filterProvider;

    if(currentFilter == "residential") {
      filtersBathBedPark = [
        const FiltersBedrooms(),
        const FiltersBathrooms(),
        const SizedBox( height: 28.0, ),
      ];
    } else if (currentFilter == "condo") {
      filtersBathBedPark = [
        const FiltersBedCondo(),
        const FiltersBathrooms(),
        //const FiltersParkCondo(),
        const SizedBox(height: 20.0)
      ];
    }

    return Column(
      children: filtersBathBedPark,
    );    
  }
}