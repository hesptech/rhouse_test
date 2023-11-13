import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

class GameGuessPriceDb extends StatefulWidget {

  
  final bool cardGameEmpty;

  const GameGuessPriceDb({super.key, required this.cardGameEmpty});

  @override
  State<GameGuessPriceDb> createState() => _GameGuessPriceDbState();
}

class _GameGuessPriceDbState extends State<GameGuessPriceDb> {

  late final TextEditingController _guessPrice;

  @override
  void initState() {
    super.initState();
    _guessPrice = TextEditingController(text: "\$ 1,780,000");
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _guessPrice,               
      keyboardType: TextInputType.number,
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
        contentPadding: const EdgeInsets.only(top: 0.0, right: 0.0, left: 15.0, bottom: 0.0),
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
          padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
          child: const Icon(
            Icons.lock_outlined,
            color: Colors.grey,
            size: 18,
          )),
    );
  }
}