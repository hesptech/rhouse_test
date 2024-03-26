import 'package:flutter/material.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_scroll_horizontal/card_hor.dart';
import 'package:flutter_black_white/providers/repliers_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:provider/provider.dart';


class CardsSliderHor extends StatefulWidget {

  final List<Listing> listing;
  final String? title;
  final Function onNextPage;
  final Function onInitPage;

  const CardsSliderHor({
    Key? key, 
    required this.listing, 
    this.title, 
    required this.onNextPage, 
    required this.onInitPage
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

    final repliersProviders = Provider.of<RepliersProvider>(context);

    return SizedBox(
      width: double.infinity,
      height: 415,
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
                  child: Text(widget.title!, style: const TextStyle( fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF58595B)),),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.fromLTRB(0, 10.0, 15.0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    //Navigator.pushNamed( context, 'custom-selection', arguments: widget.title );
                  }, 
                  //child: const Text('See More', style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.w400),),
                  child: const Text('', style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.w400),),
                ),
              ],
            ),

          // CARD Horizontal
          repliersProviders.isLoadingCondo ? 
          //const CircularProgressIndicator( color: kPrimaryColor, )
          //const Text('data')
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: CircularProgressIndicator( color: kPrimaryColor, ),
            ),
          )
          : Expanded(
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