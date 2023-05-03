import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class ExpansionRoom extends StatelessWidget {

  final Listing listing;

  const ExpansionRoom( this.listing, {Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(listing);

    return Column(
      children: [

      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listing.rooms?.length,
        scrollDirection: Axis.vertical,
        //itemBuilder: ( _, int index ) => Text( index.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kSecondaryColor, height: 1.3, ), )
        //itemBuilder: ( _, int index ) => Text( listing.rooms?[(index + 1).toString()]?.features?? '-', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kSecondaryColor, height: 1.3, ), )
        //itemBuilder: ( _, int index ) => _RoomDescription( room: listing.rooms?[index])
        itemBuilder: ( _, int index ) => Column(
          children: [
            const SizedBox( height: 10.0, ),
            if(dataFormatted.emptyDataCheck( listing.rooms?[(index + 1).toString()]?.level?? '-' )) Row(
              children: [
                Text( '${listing.rooms?[(index + 1).toString()]?.level?? '-'} level', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1.3, ), ),
              ],
            ),
            Row(
              children: [
                if(dataFormatted.emptyDataCheck( listing.rooms?[(index + 1).toString()]?.description?? '-' )) SizedBox(
                  width: 120.0,
                  child: Text( listing.rooms?[(index + 1).toString()]?.description?? '-', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1.3, ), )
                ),
                if(dataFormatted.emptyDataCheck( listing.rooms?[(index + 1).toString()]?.length?? '-' )) Text( '${listing.rooms?[(index + 1).toString()]?.length?? '-'} ft', style: const TextStyle( fontWeight: FontWeight.w700, height: 1.3, ), ),
                if(dataFormatted.emptyDataCheck( listing.rooms?[(index + 1).toString()]?.length?? '-' )) const Text( ' x ', style: TextStyle( fontWeight: FontWeight.w700, height: 1.3, ), ),
                if(dataFormatted.emptyDataCheck( listing.rooms?[(index + 1).toString()]?.width?? '-' )) Text( '${listing.rooms?[(index + 1).toString()]?.width?? '-'} ft', style: const TextStyle( fontWeight: FontWeight.w700, height: 1.3, ), ),
              ],
            ),
            if(dataFormatted.emptyDataCheck( listing.rooms?[(index + 1).toString()]?.features?? '-' )) Row(
              children: [
                const SizedBox(
                  width: 120.0,
                  child: Text( ' ', )
                ),
                Text( listing.rooms?[(index + 1).toString()]?.features?? '-', ),
              ],
            ),
            if(dataFormatted.emptyDataCheck( listing.rooms?[(index + 1).toString()]?.features2?? '-' )) Row(
              children: [
                const SizedBox(
                  width: 120.0,
                  child: Text( ' ', )
                ),
                Text( listing.rooms?[(index + 1).toString()]?.features2?? '-', ),
              ],
            ),
            if(dataFormatted.emptyDataCheck( listing.rooms?[(index + 1).toString()]?.features3?? '-' )) Row(
              children: [
                const SizedBox(
                  width: 120.0,
                  child: Text( ' ', )
                ),
                Text( listing.rooms?[(index + 1).toString()]?.features3?? '-', ),
              ],
            ),
          ],
        ),
      ),
      ],
    );
  }
}


/* class _RoomDescription extends StatelessWidget {
  
  final dynamic room;

  const _RoomDescription({ Key? key, required this.room }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print(room.toString());

    return Column(
      children: const [
        Text('data')
      ],
    );
  }
} */



    /* return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listing.rooms?.length,
          scrollDirection: Axis.vertical,
          itemBuilder: ( _, int index )  
            {
              return Text( index.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kSecondaryColor, height: 1.3, ), );
            }
        ),
      ],
    ); */