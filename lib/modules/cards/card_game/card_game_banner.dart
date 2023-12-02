import 'package:flutter/material.dart';

import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/utils/card_full_description_arguments.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_last_status.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_guess_price_db.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_guess_richtext.dart';

class CardGameBanner extends StatelessWidget {

  final Listing propertyItem;

  const CardGameBanner(this.propertyItem, {super.key});

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(propertyItem);
    final String images = propertyItem.images?.first?? '';
    final statusParams = GameLastStatus(propertyItem);
    final bool labelStatus = statusParams.priceLabel == 'SOLD PRICE: ' ? true : false ;
    String formattedPrice = '---';

    if( statusParams.price.length > 4 ) {
      double doubleString = double.parse(statusParams.price);
      formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric( horizontal: 10.0, vertical: 7.0),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
          Navigator.pushNamed(
            context, 
            'card_details_full_screen', 
            arguments: CardFullDescriptionArguments(propertyItem, 'card_game_banner')
          );
        }, 
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    FadeInImage(
                      placeholder: const AssetImage('assets/no-image_128_85.jpg'), 
                      image: NetworkImage('$kRepliersCdn$images?w=250'),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/no-image_128_85.jpg', 
                          fit: BoxFit.cover,
                        );
                      },
                      width: 165,
                      height: 140,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      width: 165,
                      height: 140,
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        bottom: 10.0,
                      ),
                      alignment: Alignment.bottomLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Container(
                          color: statusParams.colorLabel,
                          width: 120.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  statusParams.iconLabel,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),                             
                                Text(
                                  statusParams.lastStatusHistory,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text( 
                            dataFormatted.address,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                            ),
                          )
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text( dataFormatted.addressCity, ),
                        ),
                        const SizedBox(height: 5.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              statusParams.priceLabel,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: labelStatus ? FontWeight.bold : FontWeight.normal, 
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formattedPrice, 
                              style: TextStyle(
                                fontSize: 18, 
                                color: kPrimaryColor,
                                fontWeight: labelStatus ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 160.0,
                            height: 35.0,
                            child: GameGuessPriceDb( cardGameEmpty: false, propertyItem: propertyItem, )
                          ),
                        ),
                      ],
                    ),
                  )
                )          
              ],    
            ),
            const SizedBox(height: 15.0,),
            GameGuessRichtext(propertyItem: propertyItem),
          ],
        ),
      ),
    );
  }
}