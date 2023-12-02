import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/models/models.dart';

class GameGuessPriceDb extends StatelessWidget {

  final bool cardGameEmpty;
  final Listing propertyItem;

  const GameGuessPriceDb({super.key, required this.cardGameEmpty, required this.propertyItem});





  @override
  Widget build(BuildContext context) {

    final smallScreen = MediaQuery.of(context).size.width < 361 ? true : false ;
    //widget.propertyItem.mlsNumber 
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    final priceGameDb= filterProvider.gameTempObj[propertyItem.mlsNumber];
    final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      locale: 'ko',
      decimalDigits: 0,
      symbol: '\$ ',      
    );

    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter(
          locale: 'ko',
          decimalDigits: 0,
          symbol: '\$ ',
        ),
      ], 
      initialValue: formatter.format(priceGameDb?? ''),             
      keyboardType: TextInputType.number,
      textAlign: TextAlign.left,
      readOnly: true,
      //maxLines: 2,
      style: TextStyle(
        height: 1.7,
        color: kWarningColor,
        fontSize: smallScreen ? 14 : 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        //hintText: "guess Price",
        labelText: "Your guess SOLD Price",
        contentPadding: EdgeInsets.only(left: smallScreen ? 10.0 : 15.0 ),
        suffixIcon: _suffixGuessPrice(),
        suffixIconConstraints: const BoxConstraints(minWidth: 32.0),
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
    return const Icon(
      Icons.lock_outlined,
      color: Colors.grey,
      size: 18,
    );
  }
}