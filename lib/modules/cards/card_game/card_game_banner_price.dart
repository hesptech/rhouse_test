import 'package:flutter/material.dart';

import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/utils/card_full_description_arguments.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_last_status.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_guess_price.dart';

class CardGameBannerPrice extends StatelessWidget {

  final Listing propertyItem;

  const CardGameBannerPrice(this.propertyItem, {super.key});

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(propertyItem);
    final String images = propertyItem.images?.first?? '';
    final statusParams = GameLastStatus(propertyItem);
    String formattedPrice = '---';

    if( statusParams.price.length > 4 ) {
      double doubleString = double.parse(statusParams.price);
      formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }

    //final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);

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
              arguments: CardFullDescriptionArguments(propertyItem, 'game_screen')
            );
          }, 
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
                          const SizedBox(
                            height: 40.0,
                            child: GameGuessPrice( cardGameEmpty: true,),
                          ),
                        ],
                      ),
                    )
                  )          
                ],    
              ),
              const SizedBox(width: 5.0,),
              Row(
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
                    child: _buttondRegister(context)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //Widget _buttondRegister(BuildContext context, registerFormProvider) {
  Widget _buttondRegister(BuildContext context) {

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
      onPressed: () {
        
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
}