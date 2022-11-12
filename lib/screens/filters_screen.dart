import 'package:flutter/material.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';
import 'package:flutter_black_white/filters/filters.dart';


class FiltersScreen extends StatelessWidget {
  const FiltersScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Personalize Listing'),
      ),
      body: const FiltersExpansionTiles(),
      bottomNavigationBar: const FiltersBottomBar(),
    );
  }
}


class FiltersExpansionTiles extends StatefulWidget {
  const FiltersExpansionTiles({ Key? key }) : super(key: key);

  @override
  State<FiltersExpansionTiles> createState() => _FiltersExpansionTilesState();
}

class _FiltersExpansionTilesState extends State<FiltersExpansionTiles> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Container(
            height: 5,
            color: kSecondaryColor,
          ),
          const FiltersPriceRange(),
          const FiltersClassIconsBt(),
          const SizedBox( height: 28.0,),
          const GreenDivider(),
          const FiltersPropertyType(),
          const GreenDivider(),
          const FiltersLocation(),
          const GreenDivider(),
          const FiltersBedrooms(),
          const FiltersBathrooms(),
          const FiltersMore(),
        ],
      ),
    );
  }
}
