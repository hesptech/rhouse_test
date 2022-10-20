import 'package:flutter/material.dart';

//import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/filters/filters_tr_central.dart';
import 'package:flutter_black_white/filters/filters_tr_east.dart';

class FiltersLocation extends StatefulWidget {
  const FiltersLocation({Key? key}) : super(key: key);

  @override
  State<FiltersLocation> createState() => _FiltersLocationState();
}

class _FiltersLocationState extends State<FiltersLocation> {

  late List<bool> _openCloseIcons;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
      false,
      false,
      false,
    ];     
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent), 
        child: Column(
          children: [
            const Divider(
              thickness: 2.0, 
              color: kSecondaryColor, 
              indent: 24.0, 
              endIndent: 24.0, 
              height: 0,              
            ),
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              title: const Text('LOCATION', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
              trailing: Icon(
                _openCloseIcons[0] ? Icons.remove : Icons.add,
                color: kSecondaryColor,
              ),
              children: <Widget>[
                ExpansionTile(
                  title: const Text('TORONTO', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
                  trailing: Icon(
                    _openCloseIcons[1] ? Icons.remove : Icons.add,
                    color: kPrimaryColor,
                    size: 18.0,
                  ),
                  children: const [
                    FiltersTrCentral(),
                    SizedBox( height: 16.0,),
                    FiltersTrEast(),
                    SizedBox( height: 16.0,)
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _openCloseIcons[1] = expanded );
                  },
                ),
                const Divider( 
                  thickness: 1.0, 
                  color: kPrimaryColor, 
                  indent: 12.0, 
                  endIndent: 12.0, 
                  height: 0,
                ),
                ExpansionTile(
                  title: const Text('SUBURBS AND CITY OUT SKIRTS', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
                  trailing: Icon(
                    _openCloseIcons[2] ? Icons.remove : Icons.add,
                    color: kPrimaryColor,
                    size: 18.0,
                  ),
                  children: [
                    Column(
                      children: [
                        const SizedBox( height: 1.0, ),
                        const Divider( 
                          thickness: 1.0, 
                          color: kPrimaryColor, 
                          indent: 12.0, 
                          endIndent: 12.0, 
                          height: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('GTA West', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
                              TextButton(
                                onPressed: () {}, 
                                child: Text( 'Select all', style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: kSecondaryColor),),
                              )
                            ],
                          ),
                        )                        
                      ],
                    )
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _openCloseIcons[2] = expanded );
                  },
                ),                
              ],
            )
          ],
      )
      ),
    );
  }
}
