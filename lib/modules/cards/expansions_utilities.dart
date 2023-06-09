import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';

class ExpansionUtilities extends StatefulWidget {

  final Listing listing;

  const ExpansionUtilities( this.listing, {Key? key, }) : super(key: key);

  @override
  State<ExpansionUtilities> createState() => _ExpansionUtilitiesState();
}

class _ExpansionUtilitiesState extends State<ExpansionUtilities> {
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

    // Properties descriptions formatting
    final String waterSource = widget.listing.details?.waterSource?? '';
    final String heating = widget.listing.details?.heating?? '';
    final String airConditioning = widget.listing.details?.airConditioning?? '';


    return ExpansionTile(
      tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      childrenPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      title: const Text('UTILITIES', 
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
                  const Text('Water: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(waterSource, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              Row(
                children: [
                  const Text('Heat Type: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(heating, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              Row(
                children: [
                  const Text('Air Conditioning: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(airConditioning, style: const TextStyle(fontSize: 16, height: 1.3), ),
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