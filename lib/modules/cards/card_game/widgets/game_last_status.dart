import 'package:flutter/material.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/models/models.dart';

class GameLastStatus  {

  final Listing propertyItem;
  String price = '';
  String formattedPrice = '---';
  String dateHistory = '';
  String lastStatusHistory = '';
  String priceLabel = '';
  Color colorLabel = Colors.transparent;
  IconData iconLabel = Icons.lock_outlined;


  GameLastStatus(this.propertyItem) {
    lastStatusParams();
  }

  void lastStatusParams() {
    if(propertyItem.lastStatus == 'Sld') {
      //dateHistory = soldDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = propertyItem.soldPrice?? '';
      lastStatusHistory = 'SOLD';
      priceLabel = 'SOLD PRICE: ';
      colorLabel = kWarningColor;
      iconLabel = Icons.do_disturb_off_outlined;
    } else if (propertyItem.lastStatus == 'Ter') {
      //dateHistory = terminatedDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = propertyItem.listPrice?? '';
      lastStatusHistory = 'TERMINATED';
      priceLabel = 'Listed for: ';
      colorLabel = kYellow;
      iconLabel = Icons.online_prediction_outlined;
    } else if (propertyItem.lastStatus == 'Sus') {
      //dateHistory = suspendedDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = propertyItem.listPrice?? '';
      lastStatusHistory = 'SUSPENDED';
      priceLabel = 'Listed for: ';
      colorLabel = kYellow;
      iconLabel = Icons.online_prediction_outlined;
    } else if (propertyItem.lastStatus == 'Exp') {
      //dateHistory = expiryDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = propertyItem.listPrice?? '';
      lastStatusHistory = 'EXPIRED';
      priceLabel = 'Listed for: ';
      colorLabel = kYellow;
      iconLabel = Icons.online_prediction_outlined;
    } else if (propertyItem.lastStatus == 'New') {
      //dateHistory = expiryDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = propertyItem.listPrice?? '';
      lastStatusHistory = 'ACTIVE';
      priceLabel = 'Listed for: ';
      colorLabel = kSecondaryColor;
      iconLabel = Icons.online_prediction_outlined;
    } else {
      dateHistory = '   no data    ';
      price = propertyItem.listPrice?? '';
      lastStatusHistory = propertyItem.lastStatus?? '';
      priceLabel = 'Listed for: ';
      colorLabel = Colors.transparent;
      iconLabel = Icons.online_prediction_outlined;
    }
  }
}