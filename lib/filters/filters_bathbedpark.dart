import 'package:flutter/material.dart';
import 'package:flutter_black_white/filters/filters_park_condo.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/filters/filters.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/filters/filters_bed_condo.dart';
export 'package:flutter_black_white/filters/filters_bedrooms.dart';
export 'package:flutter_black_white/filters/filters_bathrooms.dart';


class FiltersBathbedpark extends StatefulWidget {
  const FiltersBathbedpark({Key? key}) : super(key: key);

  @override
  State<FiltersBathbedpark> createState() => _FiltersBathbedparkState();
}

class _FiltersBathbedparkState extends State<FiltersBathbedpark> {

  late List<Widget> filtersBathBedPark;

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
    } else if (currentFilter == "&class=condo") {
      filtersBathBedPark = [
        const FiltersBedCondo(),
        const FiltersBathrooms(),
        const FiltersParkCondo(),
      ];
    }

    return Column(
      children: filtersBathBedPark,
    );    
  }
}