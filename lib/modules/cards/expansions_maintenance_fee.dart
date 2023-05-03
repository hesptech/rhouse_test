import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';

class ExpansionMaintenance extends StatefulWidget {

  final Listing listing;

  const ExpansionMaintenance( this.listing, {Key? key, }) : super(key: key);

  @override
  State<ExpansionMaintenance> createState() => _ExpansionMaintenanceState();
}

class _ExpansionMaintenanceState extends State<ExpansionMaintenance> {
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
      title: const Text('MAINTENANCE FEE', 
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
                  const Text('Maintenance Fee: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text( 
                    '\$${widget.listing.condominium?.fees.maintenance?? ''}' , 
                    style: const TextStyle(fontSize: 16, height: 1.3), 
                  ),
                ]
              ),
              Row(
                children: const [
                  Text(
                    'Included in Maintenance Costs', 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 2.3, ), ),
                ]
              ),
              Row(
                children: [
                  const Text('Heat Included: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text( 
                    widget.listing.condominium?.fees.heatIncl?? '' , 
                    style: const TextStyle(fontSize: 16, height: 1.3), 
                  ),
                ]
              ),
              Row(
                children: [
                  const Text('Hydro Included: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text( 
                    widget.listing.condominium?.fees.hydroIncl?? '' , 
                    style: const TextStyle(fontSize: 16, height: 1.3), 
                  ),
                ]
              ),
              Row(
                children: [
                  const Text('Water Included: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text( 
                    widget.listing.condominium?.fees.waterIncl?? '' , 
                    style: const TextStyle(fontSize: 16, height: 1.3), 
                  ),
                ]
              ),
              Row(
                children: [
                  const Text('Cable T.V. Included: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text( 
                    widget.listing.condominium?.fees.cableInlc?? '' , 
                    style: const TextStyle(fontSize: 16, height: 1.3), 
                  ),
                ]
              ),
              Row(
                children: [
                  const Text('Condo Taxes Included: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text( 
                    widget.listing.condominium?.fees.taxesIncl?? '' , 
                    style: const TextStyle(fontSize: 16, height: 1.3), 
                  ),
                ]
              ),
              Row(
                children: [
                  const Text('Parking Included: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text( 
                    widget.listing.condominium?.fees.taxesIncl?? '' , 
                    style: const TextStyle(fontSize: 16, height: 1.3), 
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