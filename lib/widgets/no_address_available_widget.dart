import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

class NoAddressAvailableWidget extends StatelessWidget {
  const NoAddressAvailableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          SizedBox(
            height: 30,
          ),
          Icon(Icons.location_off_outlined, size: 200, color: kSecondaryColor,),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Text("No address is available for this property", textAlign: TextAlign.center, style: TextStyle(color:  Colors.black, fontSize: 18),),
          )
        ],
      ),
    );
  }
}