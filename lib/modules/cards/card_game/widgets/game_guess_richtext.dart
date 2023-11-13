import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';

class GameGuessRichtext extends StatefulWidget {
    final Listing propertyItem;
  const GameGuessRichtext({super.key, required this.propertyItem});

  @override
  State<GameGuessRichtext> createState() => _GameGuessRichtextState();
}

class _GameGuessRichtextState extends State<GameGuessRichtext> {
  @override
  Widget build(BuildContext context) {

    String formattedPrice = '---';
    if( widget.propertyItem.soldPrice!.length > 4 ) {
      double doubleString = double.parse(widget.propertyItem.soldPrice!);
      formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }

    String paragraph1 = 'This property ';
    String paragraph2 = '';
    String paragraph3 = 'for some legal reason has been taken off the market resulting in not been sold';
    if(widget.propertyItem.lastStatus == 'Sld') paragraph1 = 'This property ';
    if(widget.propertyItem.lastStatus == 'Sld') paragraph2 = 'SOLD price is $formattedPrice . ';
    if(widget.propertyItem.lastStatus == 'Sld') paragraph3 = 'Your price was off by...lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent malesuada et magna sed tincidunt.';

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: paragraph1),
          TextSpan(
            text: paragraph2, 
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          TextSpan(text: paragraph3),
        ]
      ),
    );
    /* return RichText(
      text: TextSpan(paragraph1
    ); */
  }
}