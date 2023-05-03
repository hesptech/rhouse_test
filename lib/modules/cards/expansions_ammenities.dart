import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';

class ExpansionAmmenities extends StatefulWidget {

  final Listing listing;

  const ExpansionAmmenities( this.listing, {Key? key, }) : super(key: key);

  @override
  State<ExpansionAmmenities> createState() => _ExpansionAmmenitiesState();
}

class _ExpansionAmmenitiesState extends State<ExpansionAmmenities> {
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

    List<dynamic>? ammenities = widget.listing.condominium?.ammenities?? [];
    List filteredAmmenities = [];
    for (var value in ammenities) {
      if(value.isNotEmpty) filteredAmmenities.add(value);
    }
    final String ammenitiesCondo = filteredAmmenities.join(', '); 

    return ExpansionTile(
      tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      childrenPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      title: const Text('AMMENITIES', 
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
              Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints( maxWidth: 280 ),
                    child: Text(ammenitiesCondo, style: const TextStyle(fontSize: 16, height: 1.3), ),
                  )
                ]
              ),
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