import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/cards/expansions_rooms.dart';
import 'package:flutter_black_white/utils/constants.dart';


class ExpansionsRoomsDetails extends StatefulWidget {

  final Listing listing;

  const ExpansionsRoomsDetails( this.listing, {Key? key, }) : super(key: key);

  @override
  State<ExpansionsRoomsDetails> createState() => _ExpansionsRoomsDetailsState();
}

class _ExpansionsRoomsDetailsState extends State<ExpansionsRoomsDetails> {
  late List<bool> _openCloseIcons; 

  @override
  void initState() {
    super.initState();      
    _openCloseIcons = <bool>[
      false,
    ]; 
  }

  @override
  Widget build(BuildContext context) {



    return ExpansionTile(
      tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      childrenPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      title: const Text('ROOMS/DETAILS', 
        style: TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold, 
          color: kPrimaryColor,
        ),),
      trailing: Icon(
        _openCloseIcons[0] ? Icons.remove : Icons.add,
        color: kPrimaryColor,
      ),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
          child: Column(
            children: [
              ExpansionRoom(widget.listing),
              const SizedBox( height: 25.0,),               
            ]
          ),
        ),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _openCloseIcons[0] = expanded );
      },
    );
  }
}