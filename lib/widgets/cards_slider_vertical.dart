import 'package:flutter/material.dart';
import 'package:flutter_black_white/widgets/widgets.dart';
import 'package:flutter_black_white/models/models.dart';


class CardsSliderVertical extends StatefulWidget {

  final List<Listing> listing;
  final String? title;
  final Function onNextPage;

  const CardsSliderVertical({
    Key? key, 
    required this.listing, 
    this.title, 
    required this.onNextPage
  }) : super(key: key);

  @override
  State<CardsSliderVertical> createState() => _CardsSliderVerticalState();
}


class _CardsSliderVerticalState extends State<CardsSliderVertical> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ) {
        widget.onNextPage();
      }
    });    
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    //return CardVertical(Listing Widget.listing);
    return Container(
      //width: double.infinity,
      height: 680,
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
          )
        ],
      ),
    );
  }
}