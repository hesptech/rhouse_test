import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

//import 'package:flutter_black_white/providers/filter_provider.dart';
//import 'package:flutter_black_white/providers/repliers_favorites.dart';
import 'package:flutter_black_white/models/models.dart';
//import 'package:flutter_black_white/utils/constants.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import '../cards_widgets/open_house_dates.dart';


class CardHorizontalStack extends StatefulWidget {

  final Listing listing;

  const CardHorizontalStack( this.listing, {super.key});

  @override
  State<CardHorizontalStack> createState() => _CardHorizontalStackState();
}

class _CardHorizontalStackState extends State<CardHorizontalStack> {

  bool toggle = false;

  @override
  Widget build(BuildContext context) {

    const loggedIn = true;
    final dataFormatted = DataFormatter(widget.listing);

    //final filterProvider = Provider.of<FilterProvider>(context);
    //final repliersFavorites = Provider.of<RepliersFavorites>(context);

    return loggedIn == true
      ? 
      Container(
        width: 330,
        height: 28,
        //padding: const EdgeInsets.only(left: 20.0, top: 10.0,),
        //margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        margin: dataFormatted.openHouse != '' ? const EdgeInsets.only(top: 20.0) : const EdgeInsets.only(top: 20.0, left: 20.0),
        //margin: const EdgeInsets.all(0),
        //alignment: Alignment.topCenter ,
        child: OpenHouseDates(listing: widget.listing, cardType: 'horizontal'),
      )
      : 
      Container(
        width: 310,
        height: 430,
        //color: Colors.grey.withOpacity(0.1),
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ButtonStyle( 
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF5f68be)),
          ),
          onPressed: () {
            //Navigator.pushNamed(context, 'details', arguments: listing);
          },
          child: const Text('Login required'),
        )
      )
      ;
  }
}