import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/providers/repliers_listing_mls.dart';
import 'package:flutter_black_white/utils/constants.dart';
//import 'package:flutter_black_white/utils/data_formatter.dart';


class CardDetailsHistory extends StatefulWidget {

  /* final List<History> history;
  final String? mlsNumber;
  final Function onProperty; */
  //final Listing listing;
  //final String? mlsNumber;
  final Function onHistory;
  final Function onInit;

  //const CardDetailsHistory( this.listing, this.mlsNumber, {super.key, required this.onHistory, });
  const CardDetailsHistory({super.key, required this.onHistory, required this.onInit, });

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
    //print(onHistory());
    //print(repliersListingMls.onDisplayHistory[0].timestamps.);
    //print(repliersListingMls.onDisplayHistory[0].timestamps.length);
    //print(repliersListingMls.onDisplayHistory[0].soldDate);
    //print(repliersListingMls.onDisplayHistory[0].timestamps['listingEntryDate']);
    //print(repliersListingMls.onDisplayHistory.isNotEmpty);
    //print(repliersListingMls);
    
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
        ? Container(
          margin: const EdgeInsets.symmetric( vertical: 14.0, horizontal: 30.0 ),
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
                          repliersListingMls.onDisplayHistory[index].soldPrice,
                          repliersListingMls.onDisplayHistory[index].listPrice,
                          repliersListingMls.onDisplayHistory[index].lastStatus,
                        ),
                        //const Divider( height: 14.0,  thickness: 0.8, color: kPrimaryColor, ),
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


/*     repliersListingMls.onDisplayHistory.isNotEmpty
    ? Container(
      margin: const EdgeInsets.symmetric( vertical: 14.0, horizontal: 30.0 ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('PROPERTY LISTING HISTORY', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kSecondaryColor),),
            ],
          ),

          /* const SizedBox( height: 10.0, ),
          const Divider( height: 14.0,  thickness: 0.8, color: kPrimaryColor, ),
          Row(
            children: const [
              Text('2022-02-22 ', style: TextStyle(fontSize: 18, ), ),
              Text('\$1,825,000', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
              SizedBox( width: 10.0, ),
              Text('TERMINATED', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kPrimaryColor),),
              Divider( height: 28,  thickness: 0.8, color: Color(0xFF0BB48B), ),
            ],
          ),
          const Divider( height: 14.0,  thickness: 0.8, color: kPrimaryColor, ), */

          Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: repliersListingMls.onDisplayHistory.length,
                scrollDirection: Axis.vertical,
                itemBuilder: ( _, int index ) => Column(
                  children: [
                    //const Text('data'),
                    //Text('${repliersListingMls.onDisplayHistory[(index + 1)].toString()} level'),
                    //Text(repliersListingMls.onDisplayHistory[index].soldDate.toString()),
                    //Text(repliersListingMls.onDisplayHistory[0].timestamps['terminatedDate'].toString()),
                    

                    Row(
                      children: [
                        Text(repliersListingMls.onDisplayHistory[index].timestamps['terminatedDate'].toString(), style: const TextStyle(fontSize: 10, ), ),
                        Text(repliersListingMls.onDisplayHistory[index].timestamps['soldDate'].toString(), style: const TextStyle(fontSize: 10, ), ),
                        Text(
                          listingListPrice(repliersListingMls.onDisplayHistory[index].listPrice), 
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox( width: 10.0, ),
                        Text(repliersListingMls.onDisplayHistory[index].lastStatus.toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kPrimaryColor),),
                        const Divider( height: 28,  thickness: 0.8, color: Color(0xFF0BB48B), ),
                      ],
                    ),


                    HistoryFormatter(
                      repliersListingMls.onDisplayHistory[index].soldDate.toString(),
                      repliersListingMls.onDisplayHistory[index].timestamps['terminatedDate'].toString(),
                      repliersListingMls.onDisplayHistory[index].soldPrice,
                      repliersListingMls.onDisplayHistory[index].listPrice,
                      repliersListingMls.onDisplayHistory[index].lastStatus,
                    ),
                    //const SizedBox( height: 10.0, ),
                    const Divider( height: 14.0,  thickness: 0.8, color: kPrimaryColor, ),

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('PROPERTY LISTING HISTORY', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kSecondaryColor),),
            ],
          ),
          const SizedBox(
            child: Center(child: Text('no info')),
          ),
        ],
      ),
    )
    ;
 */


  }
}


/* String listingListPrice( listPrice ) {
  double doubleString = double.parse(listPrice);
  String formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  return formattedPrice;
} */


class HistoryFormatter extends StatelessWidget {

  final String soldDate;
  final String terminatedDate;
  final String soldPrice;
  final String listPrice; 
  final String lastStatus;  //Sld Ter Exp Sus

  const HistoryFormatter( 
    this.soldDate,
    this.terminatedDate,
    this.soldPrice,
    this.listPrice, 
    this.lastStatus, 
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
    } else {
      dateHistory = '   no data    ';
      price = listPrice;
      lastStatusHistory = lastStatus;
    }

    
    if( price.length > 4 ) {
      double doubleString = double.parse(price);
      formattedPrice = '\$${doubleString.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    } 

    return 
      lastStatus == 'Sld' || lastStatus == 'Ter'  
      ? Column
      (
        children: [
          Row(
              children: [
                Text(dateHistory, style: const TextStyle(fontSize: 18, ), ),
                SizedBox(
                  width: 100.0,
                  child: Text( formattedPrice, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700), )
                ),
                const SizedBox( width: 10.0, ),
                Text( lastStatusHistory, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kPrimaryColor), ),
              ],
            ),
            const Divider( height: 14.0,  thickness: 0.8, color: kPrimaryColor, ),
        ],
      )
      : const Divider( height: 0.0,  thickness: 0.0, color: Colors.transparent, ) ;


    /* return Column(
        children: [
          Row(
            children: [
              Text(dateHistory, style: const TextStyle(fontSize: 18, ), ),
              SizedBox(
                width: 100.0,
                child: Text( formattedPrice, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700), )
              ),
              const SizedBox( width: 10.0, ),
              Text( lastStatusHistory, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kPrimaryColor), ),
            ],
          ),
          const Divider( height: 14.0,  thickness: 0.8, color: kPrimaryColor, ),
        ] 
    ); */
  }
}
