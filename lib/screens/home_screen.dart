import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_provider.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final repliersProvider = Provider.of<RepliersProvider>(context);
    final repliersStatusProperties = Provider.of<FilterProvider>(context).filtersStatusProperties;

    return Scaffold(
      appBar: const CustomAppbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox( height: 45,),

                CardsSliderHor(
                  listing: repliersProvider.onDisplayHouses,
                  title: 'HOUSE Listings',
                  onNextPage: () => repliersProvider.getDisplayHouses(repliersStatusProperties),
                ),

                CardsSliderHor(
                  listing: repliersProvider.onDisplayCondo,
                  title: 'CONDO Listings',
                  onNextPage: () => repliersProvider.getDisplayCondo(repliersStatusProperties),
                ),

              ],
            ),
          ),
          const FiltersStatusBt(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigator(),
    );    
  }
}
