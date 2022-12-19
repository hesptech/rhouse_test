import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_black_white/widgets/widgets.dart';

import 'package:flutter_black_white/providers/repliers_provider.dart';

class FiltersResultsScreen extends StatelessWidget {
  const FiltersResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final repliersProvider = Provider.of<RepliersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Filters Results'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox( height: 4, ),
            CardsSliderVertical(
              listing: repliersProvider.onDisplayHouses,
              title: 'HOUSE Listings',
              onNextPage: () => repliersProvider.getDisplayHouses(),
            ),
          ],
        ),
      ),
    );
  }
}
