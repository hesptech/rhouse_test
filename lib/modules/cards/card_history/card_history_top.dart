import 'package:flutter/material.dart';

import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/screens/map_property_screen.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/modules/cards/card_history/card_history_stack.dart';

class CardHistoryTop extends StatelessWidget {
  final Listing listing;
  final String lastStatusHistory;
  final String dateHistory;

  const CardHistoryTop(this.listing, this.lastStatusHistory, this.dateHistory, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(listing);
    final screenSize = MediaQuery.of(context).size;
    final String images = listing.images?.first?? '';

    return Container(
      margin: const EdgeInsets.all(14),
      child: Stack(
        children: [
          Column(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: FadeInImage(
                  height: 300,
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  //image: AssetImage('assets/house_500x300.jpg'),
                  image: NetworkImage('$kRepliersCdn$images?w=1080'),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/no-image.jpg', fit: BoxFit.fitWidth);
                  },
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration( milliseconds: 300),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                child: Column(
                  children: [  
                    Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints( maxWidth: screenSize.width - 110 ),
                          child: Text( dataFormatted.address, textAlign: TextAlign.left ,maxLines: 3, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor, overflow: TextOverflow.ellipsis, ),),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        height: 30,
                        child: FittedBox(
                          child: Text(
                            dataFormatted.addressCity,
                            style: const TextStyle(
                              //fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox( height: 6.0,),
                  ],
                ),
              ),
            ],
          ),
          CardHistoryStack(listing, lastStatusHistory, dateHistory),
          Container(
            width: 310,
            height: 280,
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.bottomLeft,
            child: InkWell(
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Icon(Icons.map_outlined, color: kSecondaryColor, size: 30),
              ),
              onTap: () {
                Navigator.pushNamed(context, MapPropertyScreen.pathScreen, arguments: {'listing': listing});
              },
            ),
          ),
        ],
      )
    );
  }
}
