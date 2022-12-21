import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';


class CardsSliderFilters extends StatefulWidget {

  final List<Listing> listing;
  final String? title;
  final Function onNextPage;

  const CardsSliderFilters({
    Key? key, 
    required this.listing, 
    this.title, 
    required this.onNextPage
  }) : super(key: key);

  @override
  State<CardsSliderFilters> createState() => _CardsSliderFiltersState();
}

class _CardsSliderFiltersState extends State<CardsSliderFilters> {

  final ScrollController scrollController = ScrollController();
  //late String filtersClassIconsBt;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ) {
        widget.onNextPage();
      }
    });

    //filtersClassIconsBt = Preferences.filtersClassIconsBt;

  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 2.0,
    );
  }
}