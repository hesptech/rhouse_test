import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/cards/card_game/card_game.dart';
import 'package:provider/provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/providers/repliers_game.dart';

class CardsSliderGame extends StatefulWidget {
  
  final List<Listing> listing;
  final Function onInitPage;

  const CardsSliderGame({
    super.key, 
    required this.listing,
    required this.onInitPage,
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
    print(repliersGame.onCount);

    return Container(
      height: screenSize.height - 60,
      color: kBackgroundColor,
      child: !repliersGame.loaded
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
                    itemBuilder: ( _ , int index) => CardGame( widget.listing[index])
                  )
                ),
                //const Text('data'),
              ],
          ),
    );
  }
}