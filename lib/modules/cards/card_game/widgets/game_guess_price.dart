import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_game.dart';
import 'package:flutter_black_white/providers/form_game_provider.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/models/response_listings.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class GameGuessPrice extends StatefulWidget {

  final bool cardGameEmpty;
  final Listing propertyItem;

  const GameGuessPrice({super.key, required this.cardGameEmpty, required this.propertyItem});

  @override
  State<GameGuessPrice> createState() => _GameGuessPriceState();
}

class _GameGuessPriceState extends State<GameGuessPrice> {

  String price = '';
  String date = '';

  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
      create: ( _ ) => FormGameProvider(),
      child: Builder(builder: (context) {


        final filterProvider = Provider.of<FilterProvider>(context, listen: false);
        final repliersgame = Provider.of<RepliersGame>(context, listen: false);
        final formGameProvider = Provider.of<FormGameProvider>(context, listen: false);
        bool btTxt = filterProvider.cardGamePriceDisplayBtTxt;

        
        return Form(
          key: formGameProvider.formKey,
          child: Column(
            children: [
        
 
              TextFormField(
                validator: ( value ) {
                  if( value == null || value.isEmpty ) return 'Type a value';
                  return null;
                },
                //controller: _guessPrice, 
                inputFormatters: <TextInputFormatter>[
                  CurrencyTextInputFormatter(
                    locale: 'ko',
                    decimalDigits: 0,
                    symbol: '\$ ',
                  ),
                ],             
                keyboardType: const TextInputType.numberWithOptions(),
                onChanged: (value) => price = value,
                textAlign: TextAlign.left,
                readOnly: !btTxt ? false : true,
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
                  suffixIcon: !btTxt ? null : _suffixGuessPrice(),
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
              ),
        

              if (!btTxt) ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  //minimumSize: const Size(320, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: kWarningColor,
                ),
                child: const Text(
                  "SUBMIT & LEARN", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () async {
          
                  formGameProvider.validatedForm();
                  
                  price = price.replaceAll('\$ ', '').trim().replaceAll(',', '').trim();
                  date = widget.propertyItem.timestamps?.expiryDate.toString()?? '';
            
                  //filterProvider.cardGamePriceDisplay = false;
                  final insertGameSuccess = await repliersgame.getInsertGame(Preferences.userId.toString(), widget.propertyItem.mlsNumber.toString(), price, date);
                  
                  if (insertGameSuccess[0] == '0-success') {
                    filterProvider.cardGamePriceDisplayBtTxt = true;
                    if(!filterProvider.gameTemp.contains(widget.propertyItem.mlsNumber?? '')) {

                      filterProvider.gameTemp.add(widget.propertyItem.mlsNumber?? '');
                      filterProvider.gameTempObj[widget.propertyItem.mlsNumber.toString()] = price;
                      //print(filterProvider.gameTempObj);
                      
                    } else {

                    }
                  }
            
                  if(!filterProvider.gameTemp.contains('0')){
                    filterProvider.gameTemp.add('0');
                  }          
          
                },
              ),
        
            ],
          ),
        );



      }),
      
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