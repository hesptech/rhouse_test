import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

class CardDetailsMap extends StatelessWidget {
  const CardDetailsMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide( color: kSecondaryColor, width: 2.0 ) 
            ),
            borderOnForeground: true,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            child: const FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: AssetImage('assets/house_map.png'),
              fit: BoxFit.cover,
            ),
          );
  }
}