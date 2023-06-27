import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_scroll_vertical/card_vertical.dart';
import 'package:flutter_black_white/providers/repliers_filters.dart';
import 'package:flutter_black_white/utils/constants.dart';
//import 'package:flutter_black_white/widgets/widgets.dart';


class CardsSliderFilters extends StatefulWidget {

  final List<Listing> listing;
  //bool? loaded;
  //int? countListings;
  //late final int countListings;
  final Function onNextPage;
  final Function onInitPage;

  const CardsSliderFilters({
    Key? key, 
    required this.listing,
    //this.loaded,
    //this.countListings = 0, 
    required this.onNextPage,
    required this.onInitPage,
  }) : super(key: key);

  @override
  State<CardsSliderFilters> createState() => _CardsSliderFiltersState();
}

class _CardsSliderFiltersState extends State<CardsSliderFilters> {

  final ScrollController scrollController = ScrollController();
  final Map<String, dynamic> filtersResults = {};

  @override
  void initState() {
    super.initState();
    widget.listing.clear();
    widget.onInitPage();
    scrollController.addListener(() {
      if ( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ) {
        widget.onNextPage();
      }
    });
    //widget.countListings = 0;
    //widget.loaded = false;
  }

  @override
  void dispose(){
    super.dispose();
  }


  Future<List<Listing>> allUsers() async {
    if (widget.listing.isNotEmpty) {
      return widget.listing;
    } else {
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    final repliersFilters = Provider.of<RepliersFilters>(context);
    bool countEmpty = (repliersFilters.onCount > 0) ? false : true  ; 

    
    return Container(
      height: screenSize.height - 60,
      color: kBackgroundColor,
      child: !repliersFilters.loaded
        ? const Center(
            child: CircularProgressIndicator( color: kPrimaryColor, ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: countEmpty 
            ? [
                const Center(
                  heightFactor: 5.0,
                  child: Text(
                    'sorry, \n no Properties found', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]
            : [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.listing.length,
                    itemBuilder: ( _ , int index) => CardVertical( widget.listing[index])
                  )
                ),
              ],
          ),
    );
  }
}