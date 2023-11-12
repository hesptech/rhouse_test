import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_game/card_game_banner.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_last_status.dart';

class CardGame extends StatefulWidget {

  final Listing propertyItem;

  const CardGame(this.propertyItem, {super.key});

  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {

  late final TextEditingController _guessPrice;

  @override
  void initState() {
    super.initState();
    _guessPrice = TextEditingController(text: "\$ 1,780,000");
  }

  /* @override
  void dispose() {
    super.dispose();
    ScaffoldMessenger.of(context).clearMaterialBanners();
  } */

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ScaffoldMessenger.of(context).clearMaterialBanners();
  }

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(widget.propertyItem);
    final String images = widget.propertyItem.images?.first?? '';
    final statusParams = GameLastStatus(widget.propertyItem);
    String formattedPrice = '---';

    if( statusParams.price.length > 4 ) {
      double doubleString = double.parse(statusParams.price);
      formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric( horizontal: 10.0, vertical: 3.0),
      child: GestureDetector(
        onTap: () {
          Provider.of<FilterProvider>(context, listen: false).cardGamePriceDisplay = false;
          ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
          //ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          return showBanner();
        }, 
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                          fit: BoxFit.fitWidth
                        );
                      },
                      width: 150,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 150,
                      height: 120,
                      child: Center(
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
                          child: Text( dataFormatted.address,)
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text( dataFormatted.addressCity, ),
                        ),
                        const SizedBox(height: 3.0,),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              statusParams.priceLabel,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formattedPrice,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
                            ),
                            /* Container(
                              padding: const EdgeInsets.symmetric( vertical: 2, horizontal: 5.0 ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: kPrimaryColor),
                              ),
                              child: Text(
                                widget.propertyItem.details?.propertyType?? '', 
                                style: const TextStyle(fontSize: 12, color: kPrimaryColor,),
                              ),
                            ), */
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                         Align(
                            alignment: Alignment.centerLeft,
                           child: SizedBox(
                            width: 150,
                            height: 35,
                            child: _guessPriceTextForm()),
                         )
                  
          
                      ],
                    ),
                  )
                )          
              ],    
            ),
          ),
        ),
      ),
    );
  }

  void showBanner() => ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      elevation: 5.0,
      backgroundColor: Colors.white,
      //padding: const EdgeInsets.all(16),
      content: Column(
        children: [
          CardGameBanner(widget.propertyItem),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(), 
          child: const Text(''),
        ),
        IconButton(
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          icon: const Icon(Icons.cancel_outlined)
        ),
      ]
    ),
  );

  Widget _guessPriceTextForm() {
    return TextFormField(
      controller: _guessPrice,               
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.left,
      readOnly: true,
      //maxLines: 2,
      style: const TextStyle(
        height: 1.7,
        color: kWarningColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        //hintText: "guess Price",
        labelText: "Your guess SOLD Price",
        contentPadding: const EdgeInsets.only(top: 0.0, right: 0, left: 15.0, bottom: 0.0),
        suffixIcon: _suffixGuessPrice(),
        suffixIconColor: kWarningColor,
        labelStyle: const TextStyle(
          color: kWarningColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.w500, color: kWarningColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: kWarningColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: kWarningColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: kWarningColor),
        ),
      ),
    );
  }

  Widget _suffixGuessPrice() {
    return InkWell(
      onTap: () {        
        //Navigator.pushNamed(context, PriceDeleteScreen.pathScreen);
      },
      child: Container(
          //height: 60,
          //width: 60,
          padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
          /* decoration: BoxDecoration(
            //color: kWarningColor,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            border: Border.all(width: 1, style: BorderStyle.solid, color: kWarningColor),
          ), */
          child: const Icon(
            Icons.lock_outlined,
            color: Colors.grey,
            size: 18,
          )),
    );
  }
}