import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

//import 'package:flutter_black_white/providers/repliers_listing_mls.dart';


class CardDetailsFullSoldScreen extends StatelessWidget {
  const CardDetailsFullSoldScreen({super.key});


  @override
  Widget build(BuildContext context) {


    final String mlsNumber = ModalRoute.of(context)?.settings.arguments! as String;
    //final repliersDisplayListing = Provider.of<RepliersListingMls>(context);
   
    //repliersDisplayListing.getListingMlsData(mlsNumber);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Image(image: AssetImage('assets/r_logo_112x38.png'), ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon( Icons.search_outlined, size: 30, ),
          ),
          const SizedBox( width: 10,)        
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(mlsNumber),

            //Text(repliersDisplayListing.onDisplayData.images?.first?? ''),
            //Text(repliersDisplayListing.onDisplayData.address?.streetName?? ''),

          ],
        ),
      ),
    );
  }
}
