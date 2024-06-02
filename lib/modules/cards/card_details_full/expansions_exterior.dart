import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';

class ExpansionsExterior extends StatefulWidget {

  final Listing listing;

  const ExpansionsExterior( this.listing, {Key? key, }) : super(key: key);

  @override
  State<ExpansionsExterior> createState() => _ExpansionsExteriorState();
}

class _ExpansionsExteriorState extends State<ExpansionsExterior> {
  
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

    // Property type
    final listingClass = widget.listing.listingClass?? '';
    final String propertyClass = listingClass == 'ResidentialProperty' ? 'house' : 'condo' ;

    // Properties descriptions formatting
    final String style = widget.listing.details?.style?? '';
    final String exteriorConstruction1 = widget.listing.details?.exteriorConstruction1?? '';
    final String garage = widget.listing.details?.garage?? '';
    final String numGarageSpaces = widget.listing.details?.numGarageSpaces?? '';
    final String swimmingPool = widget.listing.details?.swimmingPool?? '';
    final String waterSource = widget.listing.details?.waterSource?? '';
    final String handicappedEquipped = widget.listing.details?.handicappedEquipped?? '';
    final String yearBuilt = widget.listing.details?.yearBuilt?? '';
    final String sqft = widget.listing.details?.sqft?? '';
    final String balcony = widget.listing.details?.balcony?? '';

    List<dynamic>? ammenities = widget.listing.nearby?.ammenities?? [];
    List filteredAmmenities = [];
    for (var value in ammenities) {
      if(value.isNotEmpty) filteredAmmenities.add(value);
    }
    final String ammenitiesExterior = filteredAmmenities.join(', '); 


    return ExpansionTile(
      tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      childrenPadding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
      title: const Text('EXTERIOR', 
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
                  Text( propertyClass == 'house' ? 'Type: ' : 'Style: ', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(style, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              Row(
                children: [
                  const Text('Exterior: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(exteriorConstruction1, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              Row(
                children: [
                  const Text('Garage Type: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(garage, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              if ( propertyClass == 'condo') Row(
                children: [
                  const Text('Balcony: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ), 
                  Text(balcony, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              if ( propertyClass == 'house') Row(
                children: [
                  const Text('Garage Parking Spaces: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ), 
                  Text(numGarageSpaces, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              if ( propertyClass == 'house') Row(
                children: [
                  const Text('Pool: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(swimmingPool, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              if ( propertyClass == 'house') Row(
                children: [
                  const Text('Water: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(waterSource, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              Row(
                children: [
                  const Text('Physically Handicapped Equipped: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(handicappedEquipped, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              Row(
                children: [
                  const Text('Approximate Age: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ), 
                  Text(yearBuilt, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              if ( propertyClass == 'house') Row(
                children: [
                  const Text('Approx Square Footage: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(sqft, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              const Row(
                children: [
                  Text('Property Features/Area Influences: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                ]
              ),
              Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints( maxWidth: 200 ),
                    child: Text(ammenitiesExterior, style: const TextStyle(fontSize: 16, height: 1.3), ),
                  )
                ]
              ),
              if ( propertyClass == 'house') Row(
                children: [
                  const Text('Water Supply Types: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(waterSource, style: const TextStyle(fontSize: 16, height: 1.3), ),
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
