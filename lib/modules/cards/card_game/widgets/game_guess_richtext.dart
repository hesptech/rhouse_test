import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';

class GameGuessRichtext extends StatefulWidget {
    final Listing propertyItem;
  const GameGuessRichtext({super.key, required this.propertyItem});

  @override
  State<GameGuessRichtext> createState() => _GameGuessRichtextState();
}

class _GameGuessRichtextState extends State<GameGuessRichtext> {
  @override
  Widget build(BuildContext context) {

    final expiryDate = widget.propertyItem.timestamps?.expiryDate.toString().substring(0,11)?? '';

    String formattedPrice = '---';
    if( widget.propertyItem.soldPrice!.length > 4 ) {
      double doubleString = double.parse(widget.propertyItem.soldPrice!);
      formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }

    String paragraphNew1 = 'Your guess SOLD price has been submitted for this property. Listing expires on $expiryDate. \n \n';
    String paragraphNew2 = 'Thank you! ';
    String paragraphNew3 = 'We will let you know when the property is sold, and how close you were to guess the right SOLD price.';
    
    String paragraphSld1 = 'This property ';
    String paragraphSld2 = 'SOLD price is $formattedPrice. ';
    String paragraphSld3 = 'Your price was off by \$195,000. You tend to over price. Improve your real estate learning: You have guessed X property prices, and you have been off by % on average.';
    
    String paragraph = 'This property for some legal reason has been taken off the market resulting in it not being sold.';
    
    //if(widget.propertyItem.lastStatus == 'New') paragraphNew1 = 'Your guess SOLD price has been submitted for this property on November 21st, 2023. \n \n';
    if(widget.propertyItem.lastStatus == 'Sld') paragraph = 'This property ';
    if(widget.propertyItem.lastStatus == 'Sld') paragraph = 'SOLD price is $formattedPrice . ';
    if(widget.propertyItem.lastStatus == 'Sld') paragraph = 'Your price was off by...lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent malesuada et magna sed tincidunt.';

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: widget.propertyItem.lastStatus == 'New' ? paragraphNew1 : '',
            style: const TextStyle( color: kSecondaryColor )
          ),
          TextSpan(
            text: widget.propertyItem.lastStatus == 'New' ? paragraphNew2 : '',
            style: const TextStyle( fontWeight: FontWeight.bold )
          ),
          TextSpan(
            text: widget.propertyItem.lastStatus == 'New' ? paragraphNew3 : '',
          ),

          TextSpan(
            text: widget.propertyItem.lastStatus == 'Sld' ? paragraphSld1 : '',
          ),
          TextSpan(
            text: widget.propertyItem.lastStatus == 'Sld' ? paragraphSld2 : '',
            style: const TextStyle( fontWeight: FontWeight.bold )
          ),
          TextSpan(
            text: widget.propertyItem.lastStatus == 'Sld' ? paragraphSld3 : '',
          ),

          TextSpan(
            text: widget.propertyItem.lastStatus != 'New' && widget.propertyItem.lastStatus != 'Sld' ? paragraph : '',
          ),

          /* TextSpan(
            text: widget.propertyItem.lastStatus != 'Sld' ? paragraphSld3 : '',
          ),
          TextSpan(
            text: paragraph, 
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          TextSpan(text: paragraph), */
        ]
      ),
    );
    /* return RichText(
      text: TextSpan(paragraph1
    ); */
  }
}