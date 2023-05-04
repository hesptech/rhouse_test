import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/data_formatter.dart';

class CardStackItems extends StatefulWidget {

  
  final Listing listing;

  const CardStackItems( this.listing, {Key? key}) : super(key: key);

  @override
  State<CardStackItems> createState() => _CardStackItemsState();
}

class _CardStackItemsState extends State<CardStackItems> {
  @override
  Widget build(BuildContext context) {

    final dataFormatted = DataFormatter(widget.listing);

    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric( horizontal: 20.0, vertical: 10.0 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E3191),
              minimumSize: const Size(140.0, 28.0),
              padding: const EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              //Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: Row(
              children: [
                const Icon(Icons.calendar_month_outlined, size: 16),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  dataFormatted.listEntryDate,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400,),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Stack(
                children: [
                  const Positioned(
                    left: 1.0,
                    top: 2.0,
                    child: Icon(Icons.favorite_border_outlined, color: Colors.black26, size: 30),
                  ),
                  InkWell(
                    child: const Icon(Icons.favorite_border_outlined, color: Color(0xFFffffff), size: 30),
                    onTap: () {
                      //print('object');
                    },
                  )                              
                ],
              ),
              const SizedBox(width: 7.0,),
              Stack(
                children: [
                  const Positioned(
                    left: 1.0,
                    top: 2.0,
                    child: Icon(Icons.filter_9_plus_outlined, color: Colors.black26, size: 30),
                  ),
                  InkWell(
                    child: const Icon(Icons.filter_9_plus_outlined, color: Color(0xFFffffff), size: 30),
                    onTap: () {
                      Navigator.pushNamed(context, 'card_images_screen', arguments: widget.listing);
                      //print('object');
                    },
                  )                              
                ],
              )              
            ],
          ),
        ],
      ),
    );
  }
}
