import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/utils/card_full_description_arguments.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_last_status.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_guess_price.dart';

class CardGameBannerPrice extends StatefulWidget {

  final Listing propertyItem;

  const CardGameBannerPrice(this.propertyItem, {super.key});

  @override
  State<CardGameBannerPrice> createState() => _CardGameBannerPriceState();
}

class _CardGameBannerPriceState extends State<CardGameBannerPrice> {

  String price = '';
  String date = '';

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(widget.propertyItem);
    //final String images = widget.propertyItem.images?.first?? '';
    final urlImage = '$kRepliersCdn${widget.propertyItem.images![0]}?class=medium';
    final statusParams = GameLastStatus(widget.propertyItem);
    final expiryDate = widget.propertyItem.timestamps?.expiryDate.toString().substring(0,11)?? '';
    
    String formattedPrice = '---';
    if( statusParams.price.length > 4 ) {
      double doubleString = double.parse(statusParams.price);
      formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }

    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    bool btTxt = filterProvider.cardGamePriceDisplayBtTxt;


    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
        Navigator.pushNamed(
          context, 
          'card_details_full_screen', 
          arguments: CardFullDescriptionArguments(widget.propertyItem, 'game_screen')
        );
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsetsDirectional.symmetric( horizontal: 26.0, vertical: 23.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
    
                    FadeInImage(
                      placeholder: const AssetImage('assets/no_images_subs/no-image_128_85.jpg'), 
                      image: NetworkImage(urlImage),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/no_images_subs/no-image_128_85.jpg', 
                          fit: BoxFit.cover,
                        );
                      },
                      width: 165,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
    
                    !btTxt ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /* SizedBox(
                          width: 162.0,
                          child: Text(
                            'Price must be no less than \$50% % lower, and no less than 75% higher, otherwise people can put prices that are just completely out of range to increase or lower the average',
                            style: TextStyle( fontSize: 8 ),                      
                          ),
                        ), */
                        Container(
                          width: 162.0,
                          padding: const EdgeInsets.all(5.0),
                          child: const Text(
                            'Price must be no less than \$50% % lower, and no less than 75% higher, otherwise people can put prices that are just completely out of range to increase or lower the average',
                            style: TextStyle( fontSize: 8 ),                      
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                      ],
                    ) :
                    const SizedBox()
    
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
                              style: const TextStyle( fontSize: 12.0 ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formattedPrice, 
                              style: const TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold, 
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                                    
                        GameGuessPrice(cardGameEmpty: false, propertyItem: widget.propertyItem ),
 
                      ],
                    ),
                  ),
                )
              ],
            ),

            btTxt ? SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                    Padding(
                      padding: const EdgeInsets.symmetric( vertical: 10.0 ),
                      child: Text(
                        'Your guess SOLD price has been submitted for this property. Listing expires on $expiryDate.',
                        style: const TextStyle( fontSize: 14, color: kSecondaryColor, fontWeight: FontWeight.bold ),                      
                      ),
                    ),
                    const Text(
                      'Thank you!  We will let you know when the property is sold, and how close you were to guess the right SOLD price',
                      style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold),                      
                    ),
                ],
              ),
            ) :
            const SizedBox(),

          ],
        ),
      ),
    );
  }
}