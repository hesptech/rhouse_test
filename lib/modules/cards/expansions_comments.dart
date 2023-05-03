import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';


class ExpansionComments extends StatefulWidget {

  final Listing listing;
  

  const ExpansionComments( this.listing, {Key? key}) : super(key: key);

  @override
  State<ExpansionComments> createState() => _ExpansionCommentsState();
}

class _ExpansionCommentsState extends State<ExpansionComments> {

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

    final String description = widget.listing.details?.description?? '';

    return ExpansionTile(
      tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      childrenPadding: const EdgeInsets.fromLTRB( 5.0, 0, 5.0, 0, ),
      title: const Text('COMMENTS', 
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
              //const SizedBox( height: 5.0, ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      description, 
                      style: const TextStyle(fontSize: 16, color: Color(0xFF231F20), height: 1.3, ), 
                      textAlign: TextAlign.end, 
                    )
                  ),
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