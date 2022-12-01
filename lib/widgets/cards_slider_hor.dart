import 'package:flutter/material.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/widgets/card_hor.dart';


class CardsSliderHor extends StatefulWidget {

  final List<Listing> listing;
  final String? title;
  final Function onNextPage;

  const CardsSliderHor({
    Key? key, 
    required this.listing, 
    this.title, 
    required this.onNextPage
  }) : super(key: key);

  @override
  State<CardsSliderHor> createState() => _CardsSliderHorState();
}


class _CardsSliderHorState extends State<CardsSliderHor> {

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
  void dispose() {
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 410,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // COLLECTION Title
          if ( widget.title != null) 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only( top: 10, left: 20, ),
                  child: Text(widget.title!, style: const TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF58595B)),),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.fromLTRB(0, 10.0, 15.0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.pushNamed( context, 'custom-selection', arguments: widget.title );
                  }, 
                  child: const Text('See More', style: TextStyle(color: Color(0xFF0BB48B), fontWeight: FontWeight.w400),),
                ),
              ],
            ),

          // CARD Horizontal
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.listing.length,
              itemBuilder: ( _ , int index) => CardHor( widget.listing[index])
            )
          )
        ],
      ),
    );

  }
}