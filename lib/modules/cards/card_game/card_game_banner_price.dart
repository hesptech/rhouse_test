import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/providers/repliers_game.dart';
import 'package:flutter_black_white/providers/form_game_provider.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/utils/card_full_description_arguments.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_last_status.dart';
//import 'package:flutter_black_white/modules/cards/card_game/widgets/game_guess_price.dart';

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


    
    return ChangeNotifierProvider(
      create: ( _ ) => FormGameProvider(),
      child: Builder(builder: ( context ) {

        final dataFormatted = DataFormatter(widget.propertyItem);
        final String images = widget.propertyItem.images?.first?? '';
        final statusParams = GameLastStatus(widget.propertyItem);
        String formattedPrice = '---';
        

        if( statusParams.price.length > 4 ) {
          double doubleString = double.parse(statusParams.price);
          formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
        }

        //final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);
        final filterProvider = Provider.of<FilterProvider>(context, listen: false);
        final repliersgame = Provider.of<RepliersGame>(context, listen: false);
        final formGameProvider = Provider.of<FormGameProvider>(context, listen: false);
        bool btTxt = filterProvider.cardGamePriceDisplayBtTxt;
        
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric( horizontal: 10.0, vertical: 7.0),
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                //Navigator.pushNamed(context, 'card_details_full_screen', arguments: propertyItem);
                Navigator.pushNamed(
                  context, 
                  'card_details_full_screen', 
                  arguments: CardFullDescriptionArguments(widget.propertyItem, 'game_screen')
                );
              }, 
              child: Form(
                key: formGameProvider.formKey,
                child: Column(
                  children: [
                    Row(
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
                                  fit: BoxFit.cover,
                                );
                              },
                              width: 165,
                              height: 140,
                              fit: BoxFit.fitHeight,
                            ),
                            /* Container(
                              width: 165,
                              height: 140,
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                bottom: 10.0,
                              ),
                              alignment: Alignment.bottomLeft,
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
                            ), */
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
                                SizedBox(
                                  height: 40.0,
                                  //child: GameGuessPrice( cardGameEmpty: true,),
              
              
              
                                  child: TextFormField(
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
              
              
              
              
              
              
              
              
              
                                ),
                              ],
                            ),
                          )
                        )          
                      ],    
                    ),
                    const SizedBox(width: 5.0,),
                    !btTxt ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 162.0,
                          child: Text(
                            'Price must be no less than \$50% % lower, and no less than 75% higher, otherwise people can put prices that are just completely out of range to increase or lower the average',
                            style: TextStyle( fontSize: 8 ),                      
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        //_buttondRegister(context, registerFormProvider)
                        Expanded(
                          //child: _buttondRegister(context, price)
              
              
                          child: ElevatedButton(
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
              
                              //print('$price ${widget.propertyItem.mlsNumber} ${widget.propertyItem.timestamps?.expiryDate}');
                              //print(mlsprice);
              
                              //filterProvider.cardGamePriceDisplay = false;
                              final insertGameSuccess = await repliersgame.getInsertGame('1', widget.propertyItem.mlsNumber.toString(), price, date);
                              
                              if (insertGameSuccess[0] == '0-success') {
                                filterProvider.cardGamePriceDisplayBtTxt = true;
                                if(!filterProvider.gameTemp.contains(widget.propertyItem.mlsNumber?? '')) {
                                  //print(insertGameSuccess);
                                  filterProvider.gameTemp.add(widget.propertyItem.mlsNumber?? '');
                                  filterProvider.gameTempObj[widget.propertyItem.mlsNumber.toString()] = price;
                                  //print(filterProvider.gameTempObj);
                                  
                                  //repliersGame.getInsertGame( '2', listing.mlsNumber?? '');
                                } else {
                                  //filterProvider.gameTemp.removeWhere((String name) => name == listing.mlsNumber);
                                  //repliersGame.getDeleteGame( '2', listing.mlsNumber?? '');
                                }
                              }
              
                              if(!filterProvider.gameTemp.contains('0')){
                                filterProvider.gameTemp.add('0');
                              }          
                              
                              
              
              
                              //final validForm = registerFormProvider.validateForm();
                              //if ( !validForm ) return;
                              
                              /* final authProvider = Provider.of<AuthProvider>(context, listen: false);
                              authProvider.register(
                                registerFormProvider.name,
                                registerFormProvider.email, 
                                registerFormProvider.password, 
                              );
                              Navigator.pushNamed(context, RegisterTermsUseScreen.pathScreen); */
              
              
                            },
                          ),
              
              
              
              
                        ),
                      ],
                    ) :
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric( vertical: 10.0 ),
                          child: Text(
                            'Your guess SOLD price has been submitted for this property on November 21st, 2023.',
                            style: TextStyle( fontSize: 14, color: kSecondaryColor, fontWeight: FontWeight.bold ),                      
                          ),
                        ),
                        Text(
                          'Thank you!  We will let you know when the property is sold, and how close you were to guess the right SOLD price',
                          style: TextStyle( fontSize: 14, fontWeight: FontWeight.bold),                      
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );





        
      })
    );
  }

  //Widget _buttondRegister(BuildContext context, registerFormProvider) {
  Widget _buttondRegister(BuildContext context, price) {

    return ElevatedButton(
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
        print(price);
        //final validForm = registerFormProvider.validateForm();
        //if ( !validForm ) return;
        
        /* final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.register(
          registerFormProvider.name,
          registerFormProvider.email, 
          registerFormProvider.password, 
        );
        Navigator.pushNamed(context, RegisterTermsUseScreen.pathScreen); */

      },
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