import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';

class ExpansionsInterior extends StatefulWidget {

  final Listing listing;

  const ExpansionsInterior( this.listing, {Key? key}) : super(key: key);

  @override
  State<ExpansionsInterior> createState() => _ExpansionsInteriorState();
}

class _ExpansionsInteriorState extends State<ExpansionsInterior> {
  late List<bool> _openCloseIcons;
  late List<Widget> interior;

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

    final String heating = widget.listing.details?.heating?? '';
    final String airConditioning = widget.listing.details?.airConditioning?? '';
    final String numKitchens = widget.listing.details?.numKitchens?? '';
    final String basement1 = widget.listing.details?.basement1?? '';
    final String numFireplaces = widget.listing.details?.numFireplaces?? '';
    final String laundryLevel = widget.listing.details?.laundryLevel?? '';
    final String elevator = widget.listing.details?.elevator?? '';
    final String ensuiteLaundry = widget.listing.details?.ensuiteLaundry?? '';
    final String pets = widget.listing.condominium?.pets?? '';
    final String centralVac = widget.listing.details?.centralVac?? '';
    final String locker = widget.listing.details?.locker?? '';

    if ( propertyClass == 'house') {
      interior = [
        Row(
          children: [
            const Text('Kitchen: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
            Text(numKitchens, style: const TextStyle(fontSize: 16, height: 1.3), ),
          ]
        ),
        Row(
          children: [
            const Text('Basement: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
            Text(basement1, style: const TextStyle(fontSize: 16, height: 1.3), ),
          ]
        ),
        Row(
          children: [
            const Text('Fireplace/Stove (Operacional): ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
            Text(numFireplaces, style: const TextStyle(fontSize: 16, height: 1.3), ),
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
            const Text('Laundry Level: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
            Text(laundryLevel, style: const TextStyle(fontSize: 16, height: 1.3), ),
          ]
        ),
        Row(
          children: [
            const Text('Elevator/Lift: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
            Text(elevator, style: const TextStyle(fontSize: 16, height: 1.3), ),
          ]
        ),
      ];
    } else if ( propertyClass == 'condo' ) {
      interior = [
        Row(
          children: [
            const Text('Fireplace/Stove (Operacional): ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
            Text(numFireplaces, style: const TextStyle(fontSize: 16, height: 1.3), ),
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
        Row(
          children: [
            const Text('Ensuite Laundry: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
            Text(ensuiteLaundry, style: const TextStyle(fontSize: 16, height: 1.3), ),
          ]
        ),
        Row(
          children: [
            const Text('Pets Permitted: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
            Text(pets, style: const TextStyle(fontSize: 16, height: 1.3), ),
          ]
        ),
        Row(
          children: [
            const Text('Central Vacumm: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
            Text(centralVac, style: const TextStyle(fontSize: 16, height: 1.3), ),
          ]
        ),
        Row(
          children: [
            const Text('Locker: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
            Text(locker, style: const TextStyle(fontSize: 16, height: 1.3), ),
          ]
        ),
      ];
    } else {
      interior = [];
    }

    return ExpansionTile(
      tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      childrenPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      title: const Text('INTERIOR', 
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
            children: interior,
          ),
        ),
        const SizedBox( height: 25.0,),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _openCloseIcons[0] = expanded );
      },
    );
  }
}
