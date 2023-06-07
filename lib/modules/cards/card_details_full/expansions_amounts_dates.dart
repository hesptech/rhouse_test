import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';

class ExpansionsAmountsDates extends StatefulWidget {

  final Listing listing;

  const ExpansionsAmountsDates( this.listing, {Key? key}) : super(key: key);

  @override
  State<ExpansionsAmountsDates> createState() => _ExpansionsAmountsDatesState();
}

class _ExpansionsAmountsDatesState extends State<ExpansionsAmountsDates> {

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

    final String annualAmount = widget.listing.taxes?.annualAmount?? '';
    final double formatDoubleAnnualAmount = double.parse(annualAmount);
    final String formattedAnnualAmount = '\$${formatDoubleAnnualAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';

    final String assessmentYear = widget.listing.taxes?.assessmentYear?? '';
    final double formatDoubleAssessmentYear = double.parse(assessmentYear);
    final String formattedAssessmentYear = '\$${formatDoubleAssessmentYear.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';

    final String occupancy = widget.listing.occupancy?? '';

    return ExpansionTile(
      tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      childrenPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      title: const Text('AMMOUNTS/DATES', 
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
                  const Text('Taxes: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(formattedAnnualAmount, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              Row(
                children: [
                  const Text('Tax year: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(formattedAssessmentYear, style: const TextStyle(fontSize: 16, height: 1.3), ),
                ]
              ),
              Row(
                children: [
                  const Text('Possesion remarks: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                  Text(occupancy, style: const TextStyle(fontSize: 16, height: 1.3), ),
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
