import 'package:flutter/material.dart';

import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/models/models.dart';

class CardGameBanner extends StatelessWidget {

  final Listing propertyItem;

  const CardGameBanner(this.propertyItem, {super.key});

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(propertyItem);
    final String images = propertyItem.images?.first?? '';

    String price = '';
    String formattedPrice = '---';
    String dateHistory = '';
    String lastStatusHistory = '';
    String priceLabel = '';
    Color colorLabel = Colors.transparent;
    if(propertyItem.lastStatus == 'Sld') {
      //dateHistory = soldDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = propertyItem.soldPrice?? '';
      lastStatusHistory = 'SOLD';
      priceLabel = 'SOLD PRICE: ';
      colorLabel = kWarningColor;
    } else if (propertyItem.lastStatus == 'Ter') {
      //dateHistory = terminatedDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = propertyItem.listPrice?? '';
      lastStatusHistory = 'TERMINATED';
      priceLabel = 'Listed for: ';
      colorLabel = kYellow;
    } else if (propertyItem.lastStatus == 'Sus') {
      //dateHistory = suspendedDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = propertyItem.listPrice?? '';
      lastStatusHistory = 'SUSPENDED';
      priceLabel = 'Listed for: ';
      colorLabel = kYellow;
    } else if (propertyItem.lastStatus == 'Exp') {
      //dateHistory = expiryDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = propertyItem.listPrice?? '';
      lastStatusHistory = 'EXPIRED';
      priceLabel = 'Listed for: ';
      colorLabel = kYellow;
    } else if (propertyItem.lastStatus == 'New') {
      //dateHistory = expiryDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = propertyItem.listPrice?? '';
      lastStatusHistory = 'Active';
      priceLabel = 'Listed for: ';
      colorLabel = kSecondaryColor;
    } else {
      dateHistory = '   no data    ';
      price = propertyItem.listPrice?? '';
      lastStatusHistory = propertyItem.lastStatus?? '';
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
          Navigator.pushNamed(context, 'card_details_full_screen', arguments: propertyItem);
        }, 
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image_128_85.jpg'), 
                    image: NetworkImage('$kRepliersCdn$images?w=250'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/no-image_128_85.jpg', fit: BoxFit.fitWidth);
                    },
                    width: 175,
                    height: 117,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 175,
                  height: 117,
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    bottom: 10.0,
                  ),
                  alignment: Alignment.bottomLeft,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          priceLabel,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formattedPrice, 
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                        ),
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
    );
  }
}