import 'package:flutter/material.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';
import 'package:flutter_black_white/modules/filters/filters.dart';


class FiltersScreen extends StatelessWidget {
  const FiltersScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () { 
            Navigator.pushNamed(context, '/');
          }, 
          icon: const Icon(Icons.close_outlined),
        ),
        title: const Text('Personalize Listing'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              height: 5,
              color: kSecondaryColor,
            ),
            const FiltersPriceSlider(),
            const FiltersClassIconBt(),
            const SizedBox( height: 28.0,),
            const GreenDivider(),
            const FiltersPropertyType(),
            const GreenDivider(),
            const FiltersLocation(),
            const GreenDivider(),
            const FiltersBathbedpark(),
            const FiltersMore(),
          ],
        ),
      ),
      bottomNavigationBar: const FiltersBottomBar(),
    );
  }
}
