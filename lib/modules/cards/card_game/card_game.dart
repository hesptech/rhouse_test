import 'package:flutter/material.dart';

import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_game/card_game_banner.dart';

class CardGame extends StatefulWidget {

  final Listing propertyItem;

  const CardGame(this.propertyItem, {super.key});

  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {

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

    String price = '';
    String formattedPrice = '---';
    String dateHistory = '';
    String lastStatusHistory = '';
    String priceLabel = '';
    Color colorLabel = Colors.transparent;
    if(widget.propertyItem.lastStatus == 'Sld') {
      //dateHistory = soldDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = widget.propertyItem.soldPrice?? '';
      lastStatusHistory = 'SOLD';
      priceLabel = 'SOLD PRICE: ';
      colorLabel = kWarningColor;
    } else if (widget.propertyItem.lastStatus == 'Ter') {
      //dateHistory = terminatedDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = widget.propertyItem.listPrice?? '';
      lastStatusHistory = 'TERMINATED';
      priceLabel = 'Listed for: ';
      colorLabel = kYellow;
    } else if (widget.propertyItem.lastStatus == 'Sus') {
      //dateHistory = suspendedDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = widget.propertyItem.listPrice?? '';
      lastStatusHistory = 'SUSPENDED';
      priceLabel = 'Listed for: ';
      colorLabel = kYellow;
    } else if (widget.propertyItem.lastStatus == 'Exp') {
      //dateHistory = expiryDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = widget.propertyItem.listPrice?? '';
      lastStatusHistory = 'EXPIRED';
      priceLabel = 'Listed for: ';
      colorLabel = kYellow;
    } else if (widget.propertyItem.lastStatus == 'New') {
      //dateHistory = expiryDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = widget.propertyItem.listPrice?? '';
      lastStatusHistory = 'Active';
      priceLabel = 'Listed for: ';
      colorLabel = kSecondaryColor;
    } else {
      dateHistory = '   no data    ';
      price = widget.propertyItem.listPrice?? '';
      lastStatusHistory = widget.propertyItem.lastStatus?? '';
      priceLabel = 'Listed for: ';
      colorLabel = Colors.transparent;
    }

    if( price.length > 4 ) {
      double doubleString = double.parse(price);
      formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric( horizontal: 10.0, vertical: 7.0),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
          //ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          return showBanner();
        }, 
        child: Card(
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
                        return Image.asset('assets/no-image_128_85.jpg', fit: BoxFit.fitWidth);
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
                            color: colorLabel,
                            width: 120.0,
                            child: Text(
                              lastStatusHistory,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
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
                        const SizedBox(height: 5.0,),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              priceLabel,
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
                        const SizedBox(height: 5.0,),
                  
                  
          
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
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(16),
      content: Column(
        children: [
          CardGameBanner(widget.propertyItem)
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(), 
          child: const Text(''),
        ),
        TextButton(
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(), 
          child: const Text('dismiss'),
        )
      ]
    ),
  );

}