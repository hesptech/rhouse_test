import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:flutter_black_white/providers/repliers_game.dart';
import 'package:flutter_black_white/providers/repliers_favorites.dart';
//import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/cards/card_favorites/card_favorites.dart';
//import 'package:flutter_black_white/modules/cards/card_game/card_game_banner_price.dart';

class CardsSliderFavorites extends StatefulWidget {
  
  final List<Listing> listing;
  final Function onInitPage;
  final Listing? bannerPriceListing;

  const CardsSliderFavorites({
    super.key, 
    required this.listing,
    required this.onInitPage, 
    this.bannerPriceListing,
  });
  
  @override
  State<CardsSliderFavorites> createState() => _CardsSliderFavoritesState();
}

class _CardsSliderFavoritesState extends State<CardsSliderFavorites> {

  final ScrollController scrollController = ScrollController();
  final Map<String, dynamic> favoritesResults = {};

  @override
  void initState() {
    super.initState();
    widget.listing.clear();
    widget.onInitPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    final repliersFavorites = Provider.of<RepliersFavorites>(context);
    bool countEmpty = (repliersFavorites.onCount > 0) ? false : true  ;
    //print(repliersFavorites.onCount);
    //print(widget.bannerPriceListing?.mlsNumber);
    //Listing priceListing = widget.bannerPriceListing?? Listing();

    return Container(
      height: screenSize.height - 80,
      color: kBackgroundColor,
       child: !repliersFavorites.loaded
        ? const Center(
            child: CircularProgressIndicator( color: kPrimaryColor, ),
          )
        : SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: countEmpty 
              ? [
                  const SizedBox(height: 23.0,),
                  const Icon(Icons.favorite, color: kSecondaryColor, size: 42),
                  const Center(
                    heightFactor: 5.0,
                    child: Text(
                      'You haven\'t selected properties \n as FAVORITES yet.', 
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold, 
                        color: Color.fromARGB(255, 99, 99, 99),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]
              : [
                  //if (widget.bannerPriceListing?.mlsNumber != null && Provider.of<FilterProvider>(context).cardGamePriceDisplay == true) 
                  //CardGameBannerPrice( priceListing ),
        
                  const SizedBox(
                    height: 75,
                    child: Padding(
                      padding: EdgeInsets.only(top: 23, bottom: 10), 
                      child: Icon(Icons.favorite, color: kSecondaryColor, size: 42),
                      /* child: Text(
                        'Your FAVORITE Properties',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ) */
                    ),
                  ),
        
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.listing.length,
                    itemBuilder: ( _ , int index) => CardFavorites( widget.listing[index])
                  ),
                ],
            ),
        ),
    );
  }
}