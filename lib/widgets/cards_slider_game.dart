import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_game.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/cards/card_game/card_game.dart';
import 'package:flutter_black_white/modules/cards/card_game/card_game_banner_price.dart';

class CardsSliderGame extends StatefulWidget {
  
  final List<String> mlsGame; 
  final List<Listing> listing;
  final Function onInitPage;
  final Listing? bannerPriceListing;

  const CardsSliderGame({
    super.key, 
    required this.mlsGame,
    required this.listing,
    required this.onInitPage, 
    this.bannerPriceListing,
  });
  
  @override
  State<CardsSliderGame> createState() => _CardsSliderGameState();
}

class _CardsSliderGameState extends State<CardsSliderGame> {

  final ScrollController scrollController = ScrollController();
  final Map<String, dynamic> gameResults = {};

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
    final repliersGame = Provider.of<RepliersGame>(context);
    bool countEmpty = (repliersGame.onCount > 0) ? false : true  ;
    //print(repliersGame.onCount);
    Listing priceListing = widget.bannerPriceListing?? Listing();

    return Container(
      height: screenSize.height - 80,
      color: kBackgroundColor,
       child: !repliersGame.loaded
        ? const Center(
            child: CircularProgressIndicator( color: kPrimaryColor, ),
          )
        : SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: countEmpty 
              ? [
                  if (widget.bannerPriceListing?.mlsNumber != null && Provider.of<FilterProvider>(context).cardGamePriceDisplay == true) 
                  CardGameBannerPrice( priceListing ),

                  const Center(
                    heightFactor: 10.0,
                    child: Text(
                      'You don\'t have properties on your \n GUESS SOLD PRICE history yet', 
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
                  /* Container(
                    height: 100,
                    child: const Text('dddd'),
                  )
                  Flexible(
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.listing.length,
                      itemBuilder: ( _ , int index) => CardGame( widget.listing[index])
                    )
                  ), */
        
                  if (widget.bannerPriceListing?.mlsNumber != null && Provider.of<FilterProvider>(context).cardGamePriceDisplay == true) 
                  CardGameBannerPrice( priceListing ),
                  //Divider(color: Colors.grey.withOpacity(0.1), thickness: 5, height: 1,),
        
                  const SizedBox(
                    height: 50,
                    child: Padding(
                       padding: EdgeInsets.only(top: 20, bottom: 10), 
                      child: Text(
                        'YOUR GUESS PROPERTIES',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ),
                  ),
        
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.listing.length,
                    itemBuilder: ( _ , int index) => CardGame( widget.listing[index])
                  ),
                ],
            ),
        ),
    );
  }
}