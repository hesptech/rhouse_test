import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class GameGuessPrice extends StatefulWidget {  
  final bool cardGameEmpty;

  const GameGuessPrice({super.key, required this.cardGameEmpty});

  @override
  State<GameGuessPrice> createState() => _GameGuessPriceState();
}

class _GameGuessPriceState extends State<GameGuessPrice> {

  //final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //controller: _guessPrice, 
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter(
          locale: 'ko',
          decimalDigits: 0,
          symbol: '\$ ',
        ),
      ],             
      keyboardType: const TextInputType.numberWithOptions(),
      textAlign: TextAlign.left,
      readOnly: widget.cardGameEmpty ? false : true,
      //maxLines: 2,
      style: const TextStyle(
        height: 1.7,
        color: kWarningColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: "\$ 0.00",
        labelText: "Your guess SOLD Price",
        contentPadding: const EdgeInsets.only(top: 0.0, right: 0, left: 10.0, bottom: 0.0),
        suffixIcon: widget.cardGameEmpty ? null : _suffixGuessPrice(),
        suffixIconColor: kWarningColor,
        labelStyle: const TextStyle(
          color: kWarningColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.bold, color: kWarningColor, fontSize: 18.0),
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
        padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
        child: const Icon(
          Icons.lock_outlined,
          color: Colors.grey,
          size: 18,
        ),
      ),
    );
  }
}