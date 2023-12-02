import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_game/card_game_banner.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_last_status.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_guess_price_db.dart';

class CardGame extends StatefulWidget {

  final Listing propertyItem;

  const CardGame(this.propertyItem, {super.key});

  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {

  //late final TextEditingController _guessPrice;

  @override
  void initState() {
    super.initState();
    //_guessPrice = TextEditingController(text: "\$ 1,780,000");
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
    final gameAddress = dataFormatted.address.length > 24 ? '${dataFormatted.address.substring(0, 24)}...' : dataFormatted.address ;
    final gameAddressCity = dataFormatted.addressCity.length > 24 ? '${dataFormatted.addressCity.substring(0, 24)}...' : dataFormatted.addressCity ;
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
                          child: Text( gameAddress )
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text( gameAddressCity ),
                        ),
                        const SizedBox(height: 3.0,),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,                            
                            child: Row(
                              children: [
                                Text(
                                  statusParams.priceLabel,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  formattedPrice,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                       Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 160.0,
                            height: 35.0,
                            child: GameGuessPriceDb( cardGameEmpty: false, propertyItem: widget.propertyItem )
                          ),
                        ),
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
}