import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/providers/repliers_favorites.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/card_full_description_arguments.dart';
import 'package:flutter_black_white/modules/cards/card_game/widgets/game_last_status.dart';
import 'package:flutter_black_white/modules/cards/card_favorites/card_favorites_icons.dart';


class CardFavorites extends StatefulWidget {

  final Listing propertyItem;

  const CardFavorites(this.propertyItem, {super.key});

  @override
  State<CardFavorites> createState() => _CardFavoritesState();
}

class _CardFavoritesState extends State<CardFavorites> {

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(widget.propertyItem);
    final favoritesAddress = dataFormatted.address.length > 24 ? '${dataFormatted.address.substring(0, 24)}...' : dataFormatted.address ;
    final favoritesAddressCity = dataFormatted.addressCity.length > 24 ? '${dataFormatted.addressCity.substring(0, 24)}...' : dataFormatted.addressCity ;
    final String images = widget.propertyItem.images?.first?? '';
    final statusParams = GameLastStatus(widget.propertyItem);
    String formattedPrice = '---';

    if( statusParams.price.length > 4 ) {
      double doubleString = double.parse(statusParams.price);
      formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }

    final filterProvider = Provider.of<FilterProvider>(context);
    final repliersFavorites = Provider.of<RepliersFavorites>(context);


    return  filterProvider.favoritesTemp.contains(widget.propertyItem.mlsNumber) ? Padding(
      padding: const EdgeInsetsDirectional.symmetric( horizontal: 10.0, vertical: 3.0),
      child: GestureDetector(
        onTap: () {
          //Navigator.pushNamed(context, 'card_details_full_screen', arguments: widget.propertyItem);
          Navigator.pushNamed(
            context, 
            'card_details_full_screen', 
            arguments: CardFullDescriptionArguments(widget.propertyItem, 'favorites_screen')
          );
        }, 
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                Expanded(
                  //flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Column(                     
                      children: [
                        SizedBox(
                          height: 30.0,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              padding: const EdgeInsets.all(0.0),
                              onPressed: (){
                                setState(() {
                                  filterProvider.favoritesTemp.removeWhere((String name) => name == widget.propertyItem.mlsNumber);
                                  repliersFavorites.getDeleteFavorites( Preferences.userId.toString(), widget.propertyItem.mlsNumber?? '0');
                                  //Navigator.pushNamed(context, 'favorites_screen');
                                  
                                  if(!filterProvider.favoritesTemp.contains('0')){
                                    filterProvider.favoritesTemp.add('0');
                                  }
                                });
                              }, 
                              icon: const Icon(Icons.delete_outline, size: 30,)
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text( favoritesAddress )
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text( favoritesAddressCity ),
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: statusParams.lastStatusHistory == 'ACTIVE' ? Colors.black : kWarningColor,
                                  ),
                                ),
                                Text(
                                  formattedPrice,
                                  style: TextStyle(
                                    fontSize: 16, 
                                    fontWeight: FontWeight.bold, 
                                    color: statusParams.lastStatusHistory == 'ACTIVE' ? Colors.black : kWarningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0,),
                        CardFavoritesIcons(widget.propertyItem),
                      ],
                    ),
                  )
                )          
              ],    
            ),
          ),
        ),
      ),
    ) : const SizedBox();
  }
}