import 'package:flutter/material.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/cards/card_history/card_history_top.dart';
import 'package:flutter_black_white/modules/cards/card_history/card_history_box.dart';
import 'package:flutter_black_white/modules/cards/card_details_full/cards.dart';


class CardDetailsFullSoldScreen extends StatelessWidget {

  const CardDetailsFullSoldScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ScreenArguments screenArguments = ModalRoute.of(context)?.settings.arguments! as ScreenArguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Container(
            height: 5.0,
            color: kSecondaryColor,
          )
        ),
        elevation: 0,
        centerTitle: true,
        title: const Image(image: AssetImage('assets/logos/r_logo_112x38.png'), ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardHistoryTop(screenArguments.listing, screenArguments.lastStatusHistory, screenArguments.dateHistory),
            CardHistoryBox(screenArguments.listing, screenArguments.lastStatusHistory, screenArguments.formattedPrice, screenArguments.formattedHistoryListedPrice, screenArguments.mlsNumberStatus),
            const SizedBox( height: 14,),
            CardDetailsExpansions( screenArguments.listing ),

          ],
        ),
      ),
    );
  }
}
