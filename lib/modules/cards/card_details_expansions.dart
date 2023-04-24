import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';

class CardDetailsExpansions extends StatefulWidget {

  final Listing listing;

  const CardDetailsExpansions( this.listing, {Key? key}) : super(key: key);

  @override
  State<CardDetailsExpansions> createState() => _CardDetailsExpansionsState();
}

class _CardDetailsExpansionsState extends State<CardDetailsExpansions> {

  late List<bool> _openCloseIcons; 

  @override
  void initState() {
    super.initState();      
    _openCloseIcons = <bool>[
      false,
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
            //const Divider( thickness: 0.8, color: kSecondaryColor, indent: 20.0, endIndent: 20.0, height: 0,),
            ExpansionTile(
              tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              childrenPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              title: const Text(
                'Facts and Features', 
                style: TextStyle(
                  fontSize: 20, 
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
                        children: const [
                          Text('Property', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Type:', style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('Residential Detached', style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Building Type:', style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('House Single/Family', style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Style:',  style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('Rancher/Bungalow w/Bsmt.',  style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Ownnership:',  style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('Freehold NonStrata',  style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Size (sq ft):',  style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('1663',  style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Year Built:',  style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('1928',  style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Age:',  style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('94',  style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Neighborhood:',  style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('Main',  style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Finished Floor Area (Main):',  style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('907',  style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
            
                      const SizedBox( height: 18.0, ),
                      Row(
                        children: const [
                          Text('Inside', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF231F20), height: 1.3, ), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Levels:', style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('2', style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Bedrooms:', style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('3', style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Full Bathrooms:',  style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('2',  style: TextStyle(fontSize: 16, height: 1.3), ),
                        ]
                      ),
                      Row(
                        children: const [
                          Text('Half Bathrooms:',  style: TextStyle(fontSize: 16, height: 1.3), ),
                          Text('0',  style: TextStyle(fontSize: 16, height: 1.3), ),
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
            ),
            const Divider( thickness: 0.8, color: Color(0xFF0BB48B), indent: 20.0, endIndent: 20.0, height: 0, ),
            ExpansionTile(
              tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              title: Text(
                'Sold History', 
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: _openCloseIcons[1] ? const Color(0xFF2E3191) : const Color(0xFF58595B),
                ),
              ),
              trailing: Icon(
                _openCloseIcons[1] ? Icons.remove : Icons.add,
                color: _openCloseIcons[1] ? const Color(0xFF2E3191) : const Color(0xFF58595B),
              ),
              children: const <Widget>[
                ListTile( title: Text('This is tile number 1'), ),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => _openCloseIcons[1] = expanded );
              },
            ),
            const Divider( thickness: 0.8, color: Color(0xFF0BB48B), indent: 20.0, endIndent: 20.0, height: 0, ),
            ExpansionTile(
              tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              title: Text(
                'Home Value', 
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: _openCloseIcons[2] ? const Color(0xFF2E3191) : const Color(0xFF58595B),
                ),
              ),
              trailing: Icon(
                _openCloseIcons[2] ? Icons.remove : Icons.add,
                color: _openCloseIcons[2] ? const Color(0xFF2E3191) : const Color(0xFF58595B),
              ),
              children: const <Widget>[
                ListTile( title: Text('This is tile number 2'), ),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => _openCloseIcons[2] = expanded );
              },
            ),
            const Divider( thickness: 0.8, color: Color(0xFF0BB48B), indent: 20.0, endIndent: 20.0, height: 0, ),
            ExpansionTile(
              tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              title: Text(
                'Neighbourhood', 
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: _openCloseIcons[3] ? const Color(0xFF2E3191) : const Color(0xFF58595B),
                ),
              ),
              trailing: Icon(
                _openCloseIcons[3] ? Icons.remove : Icons.add,
                color: _openCloseIcons[3] ? const Color(0xFF2E3191) : const Color(0xFF58595B),
              ),
              children: const <Widget>[
                ListTile( title: Text('This is tile number 3'), ),
              ],
              onExpansionChanged: (bool expanded) {
                
                setState(() => _openCloseIcons[3] = expanded );
              },
            ),
            const Divider( thickness: 0.8, color: Color(0xFF0BB48B), indent: 20.0, endIndent: 20.0, height: 0.0,),
            const SizedBox( height: 30.0,),









            const SizedBox( height: 30.0,),
  
          ],
        ),
      ),
    );
  }
}