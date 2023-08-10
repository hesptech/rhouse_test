import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/providers/repliers_listing_mls.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/models/models.dart';

class CardDetailsHistory extends StatefulWidget {

  final Function onHistory;
  final Function onInit;
  final Listing listing;

  const CardDetailsHistory({super.key, required this.onHistory, required this.onInit, required this.listing });

  @override
  State<CardDetailsHistory> createState() => _CardDetailsHistoryState();
}

class _CardDetailsHistoryState extends State<CardDetailsHistory> {

  @override
  void initState() {
    super.initState();

    widget.onHistory();
    widget.onInit();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final repliersListingMls = Provider.of<RepliersListingMls>(context);
    
    return
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('PROPERTY LISTING HISTORY', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kSecondaryColor),),
          ],
        ),
        repliersListingMls.onDisplayHistory.isNotEmpty
        ? 
        Container(
          margin: const EdgeInsets.symmetric( vertical: 14.0, horizontal: 20.0 ),
          child: Column(
            children: [
              Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: repliersListingMls.onDisplayHistory.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: ( _, int index ) => Column(
                      children: [
                        HistoryFormatter(
                          repliersListingMls.onDisplayHistory[index].soldDate.toString(),
                          repliersListingMls.onDisplayHistory[index].timestamps['terminatedDate'].toString(),
                          repliersListingMls.onDisplayHistory[index].timestamps['expiryDate'].toString(),
                          repliersListingMls.onDisplayHistory[index].timestamps['suspendedDate'].toString(),
                          repliersListingMls.onDisplayHistory[index].soldPrice,
                          repliersListingMls.onDisplayHistory[index].listPrice,
                          repliersListingMls.onDisplayHistory[index].lastStatus,
                          repliersListingMls.onDisplayHistory[index].mlsNumber.toString(),
                          widget.listing
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
        :
        Container(
          margin: const EdgeInsets.symmetric( vertical: 14.0, horizontal: 30.0 ),
          child: Column(
            children: const [
              SizedBox(
                child: Center(child: Text('no info')),
              ),
            ],
          ),
        )
      ],
    );
  }
}


class HistoryFormatter extends StatelessWidget {


  final String soldDate;
  final String terminatedDate;
  final String expiryDate;
  final String suspendedDate;
  final String soldPrice;
  final String listPrice;
  final String lastStatus;  //Sld Ter Exp Sus Lsd
  final String mlsNumberStatus;
  final Listing listing;


  const HistoryFormatter(
    this.soldDate,
    this.terminatedDate,
    this.expiryDate,
    this.suspendedDate,
    this.soldPrice,
    this.listPrice,
    this.lastStatus,
    this.mlsNumberStatus,
    this.listing,
    {super.key}
  );


  @override
  Widget build(BuildContext context) {


    String price = '';
    String formattedPrice = '---';
    String dateHistory = '';
    String lastStatusHistory = '';
    if(lastStatus == 'Sld') {
      dateHistory = soldDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = soldPrice;
      lastStatusHistory = 'SOLD';
    } else if (lastStatus == 'Ter') {
      dateHistory = terminatedDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = listPrice;
      lastStatusHistory = 'TERMINATED';
    } else if (lastStatus == 'Sus') {
      dateHistory = suspendedDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = listPrice;
      lastStatusHistory = 'SUSPENDED';
    } else if (lastStatus == 'Exp') {
      dateHistory = expiryDate;
      dateHistory = dateHistory.length > 4 ? dateHistory.substring(0,11) : '';
      dateHistory = dateHistory == '2000-01-01' ? '0000-00-00' : dateHistory ;
      price = listPrice;
      lastStatusHistory = 'EXPIRED';
    } else {
      dateHistory = '   no data    ';
      price = listPrice;
      lastStatusHistory = lastStatus;
    }


   
    if( price.length > 4 ) {
      double doubleString = double.parse(price);
      formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }


    //final repliersListing = Provider.of<RepliersListingMls>(context);


    return
      lastStatus == 'Sld' || lastStatus == 'Ter'  ||  lastStatus == 'Sus' ||  lastStatus == 'Exp'
      ? Column
      (
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(dateHistory, style: const TextStyle(fontSize: 18, ), ),
                  SizedBox(
                    //width: 100.0,
                    child: Text( formattedPrice, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700), )
                  ),
                  const SizedBox( width: 3.0, ),
                  Text( lastStatusHistory, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kPrimaryColor), ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: (){
                  Navigator.pushNamed(
                    context,
                    'card_details_full_sold_screen',
                    arguments: ScreenArguments(listing, lastStatusHistory, dateHistory,  formattedPrice, mlsNumberStatus));
                },
                icon: const Icon( Icons.arrow_circle_right_outlined, size: 24, color: kSecondaryColor,),
              )
            ],
          ),
          const Divider( height: 14.0,  thickness: 0.8, color: kPrimaryColor, ),
        ],

      )
      : const Divider( height: 0.0,  thickness: 0.0, color: Colors.transparent, ) ;
  }
}

class ScreenArguments {
  final Listing listing;
  String lastStatusHistory = '';
  String dateHistory = '';
  String formattedPrice = '---';
  String mlsNumberStatus = '';

  ScreenArguments(this.listing, this.lastStatusHistory, this.dateHistory, this.formattedPrice, this.mlsNumberStatus);
}

