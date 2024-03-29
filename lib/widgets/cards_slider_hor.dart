import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_scroll_horizontal/card_hor.dart';
import 'package:flutter_black_white/providers/repliers_provider.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

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
    final filterProvider = Provider.of<FilterProvider>( context );

    return SizedBox(
      width: double.infinity,
      height: 415,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // COLLECTION Title
          if ( widget.title != null) 
            GestureDetector(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [    
                  /* if(widget.title! == 'HOUSE Listings' || widget.title! == 'CONDO Listings') SizedBox(
                    height: 16.0,
                    width: 30.0,
                    child: IconButton(
                        padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                        color: kSecondaryColor,
                        icon: widget.title! == 'HOUSE Listings' 
                        ? const Icon( 
                          Icons.home, size: 26.0, 
                        )
                        : const Icon( 
                          Icons.apartment, size: 26.0, 
                        ),
                        onPressed: (){
                          if(widget.title! == 'HOUSE Listings') filterProvider.filterProvider = "residential";
                          if(widget.title! == 'CONDO Listings') filterProvider.filterProvider = "condo";
                          
                          setState(() {
                            if(widget.title! == 'HOUSE Listings') Preferences.filtersClassIconsBt = 'residential';
                            if(widget.title! == 'CONDO Listings') Preferences.filtersClassIconsBt = 'condo';
                          });
                          
                          Navigator.pushNamed(context, 'filters_results_screen');
                        },
                    )
                  ), */         
                  Padding(
                    padding: const EdgeInsets.only( top: 10, left: 15, ),
                    child: Text(
                      widget.title!, 
                      style: const TextStyle( 
                        fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF58595B),
                      ),
                    ),
                  ),
                  /* TextButton(
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
                  ), */
                ],
              ),
              onTap: () {
                if(widget.title! == 'HOUSE Listings') filterProvider.filterProvider = "residential";
                if(widget.title! == 'CONDO Listings') filterProvider.filterProvider = "condo";
                
                setState(() {
                  if(widget.title! == 'HOUSE Listings') Preferences.filtersClassIconsBt = 'residential';
                  if(widget.title! == 'CONDO Listings') Preferences.filtersClassIconsBt = 'condo';
                });
                
                Navigator.pushNamed(context, 'filters_results_screen');
              },
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