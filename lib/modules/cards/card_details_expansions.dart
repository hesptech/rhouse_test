import 'package:flutter/material.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';
import 'package:flutter_black_white/modules/cards/cards.dart';

class CardDetailsExpansions extends StatelessWidget {

  final Listing listing;

  const CardDetailsExpansions( this.listing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            ExpansionComments( listing ),
            const GreenDividerSlim(),
            ExpansionsAmountsDates( listing ),
            const GreenDividerSlim(),
            if ( listing.listingClass.toString().toString() == "CondoProperty" ) ExpansionMaintenance(listing),
            if ( listing.listingClass.toString().toString() == "CondoProperty" ) const GreenDividerSlim(),
            ExpansionsExterior( listing ),
            const GreenDividerSlim(),
            ExpansionsInterior(listing),
            const GreenDividerSlim(),
            if ( listing.listingClass.toString().toString() == "CondoProperty" ) ExpansionAmmenities(listing),
            if ( listing.listingClass.toString().toString() == "CondoProperty" ) const GreenDividerSlim(),
            ExpansionsRoomsDetails(listing),
            const GreenDividerSlim(),
            if ( listing.listingClass.toString().toString() == "ResidentialProperty" ) ExpansionUtilities(listing),
            if ( listing.listingClass.toString().toString() == "ResidentialProperty" ) const GreenDividerSlim(),
            const SizedBox( height: 30.0,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text('Broker and Agent info'),
                    ],
                  ),
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints( maxWidth: 300 ),
                        child: Text(
                          listing.office?.brokerageName?? '',              
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox( height: 30.0,),





          ],
        ),
      ),
    );
  }
}