import 'package:flutter/material.dart';

///Widget showing the characteristics of the residence
class MapCardSingleBox extends StatelessWidget {
final String numBedrooms;
final String numBathrooms;
final String numParkingSpaces;


const MapCardSingleBox({super.key, required this.numBedrooms, required this.numBathrooms, required this.numParkingSpaces});


  @override
  Widget build(BuildContext context) {
        return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [        
        Expanded(
          flex: 3,
          child: Container(
            width: 68.0,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFF0BB48B)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.king_bed_outlined,
                  color: Color(0xFF0BB48B),
                  size: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    numBedrooms,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF666597),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFF0BB48B)),
                left: BorderSide(color: Color(0xFF0BB48B)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shower_outlined,
                  color: Color(0xFF0BB48B),
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    numBathrooms,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF666597),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            width: 68.0,
            padding: const EdgeInsets.all(3.5),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFF0BB48B)),
                left: BorderSide(color: Color(0xFF0BB48B)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.directions_car_filled_outlined,
                  color: Color(0xFF0BB48B),
                  size: 28,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    numParkingSpaces,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF666597),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

  }
}