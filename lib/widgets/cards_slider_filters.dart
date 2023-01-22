import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/widgets/widgets.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';


class CardsSliderFilters extends StatefulWidget {

  final List<Listing> listing;
  final String? title;
  final Function onNextPage;
  final Function onInitPage;

  const CardsSliderFilters({
    Key? key, 
    required this.listing, 
    this.title, 
    required this.onNextPage,
    required this.onInitPage,
  }) : super(key: key);

  @override
  State<CardsSliderFilters> createState() => _CardsSliderFiltersState();
}

class _CardsSliderFiltersState extends State<CardsSliderFilters> {

  final ScrollController scrollController = ScrollController();
  final Map<String, dynamic> filtersResults = {};
  late Map<String, dynamic> filtersPrefs;

  @override
  void initState() {
    super.initState();
    widget.listing.clear();
    //print(widget.listing.length);
    widget.onInitPage();
    scrollController.addListener(() {
      if ( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ) {
        widget.onNextPage();
      }
    });
    //print(widget.listing.length);
    /* Map<String, dynamic> filtersPrefs = {
        'pageNum': '1',
        'resultsPerPage': '15',
        'maxPrice': '2000000',
        'minPrice': '1500000',
        'type': 'sale',
        'hasImages': 'true',
        'class': Preferences.filtersClassIconsBt,
    };
    filtersResults.addAll(filtersPrefs); */
  }

  @override
  void dispose(){
    super.dispose();
  }


  Future<List<Listing>> allUsers() async {

    //final List<Listing> testListing = await widget.listing;

    if (widget.listing.isNotEmpty) {
      
      return widget.listing;
    } else {
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Container(
      //width: double.infinity,
      height: screenSize.height - 60,
      color: const Color(0xFFE6E7E8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          //const SizedBox( height: 3,),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              itemCount: widget.listing.length,
              itemBuilder: ( _ , int index) => CardVertical( widget.listing[index])
            )
          ),


          /* Expanded(
            child: FutureBuilder(
              future: allUsers(),
              builder: 
              (_, AsyncSnapshot<List<Listing>> s) {
                if (s.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }  

                return ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.listing.length,
                  itemBuilder: ( _ , int index) => CardVertical( widget.listing[index])
                );             
              }
            ),
          ) */




        ],
      ),
    );
  }
}