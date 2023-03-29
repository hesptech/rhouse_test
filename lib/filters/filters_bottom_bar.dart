import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

class FiltersBottomBar extends StatefulWidget {
  const FiltersBottomBar({Key? key}) : super(key: key);

  @override
  State<FiltersBottomBar> createState() => _FiltersBottomBarState();
}

class _FiltersBottomBarState extends State<FiltersBottomBar> {
  @override
  Widget build(BuildContext context) {

    return Container(
            height: 75,
            color: kSecondaryColor,
            padding: const EdgeInsets.fromLTRB(22.0, 14.0, 22.0, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white), 
                        ),
                        onPressed: () {
                            setState(() {

                            });
                        },
                        child: const Text("CLEAR", style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    const SizedBox(width: 8.0,), 
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: kPrimaryColor), 
                          backgroundColor: kPrimaryColor
                        ),
                        onPressed: () {
                          Navigator.pushNamed( context, 'filters_results_screen', arguments: 'Filtered results' );
                        },
                        child: const Text("SUBMIT", style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
                      ),
                    ),                
                  ]
                ),

              ],
            ),
              
    );
  }
}