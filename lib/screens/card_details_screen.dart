import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter/material.dart';
//import 'package:b_w0/models/models.dart';


class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final Movie movie = ModalRoute.of(context)?.settings.arguments! as Movie;
    //final Map movieMap = { 'movieId': movie.id };
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Image(image: AssetImage('assets/r_logo_112x38.png'), ),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: IconButton(
                  onPressed: () {}, 
                  icon: const Icon( Icons.search_outlined, size: 30, ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( top: 0 ),
                child: IconButton(
                  onPressed: () {}, 
                  icon: const Icon( Icons.ios_share_outlined, size: 30, ),
                ),
              ),               
            ],
          ),
          /* IconButton(
            onPressed: () {}, 
            icon: const Icon( Icons.search_outlined, size: 30, ),
          ),
          IconButton(
            onPressed: () {}, 
            icon: const Icon( Icons.output_outlined, size: 30, ),
          ), */ 
          const SizedBox( width: 10,)         
        ],
        /* flexibleSpace: SafeArea(
          child: Column(
            children: [
              Container(
                height: 5,
                color: const Color(0xFF0BB48B),
              )            
            ],
          )
        ), */
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 5,
              color: kSecondaryColor,        
            ),
            Container(
              margin: const EdgeInsets.all(14),
              child: Stack(
                children: [
                  Column(
      
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: const FadeInImage(
                          height: 300,
                          placeholder: AssetImage('assets/no-image.jpg'), 
                          image: AssetImage('assets/house_500x300.jpg'),
                          fit: BoxFit.cover,
                          fadeInDuration: Duration( milliseconds: 300),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                        child: Column(
                          children: [
      
                            Row(
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints( maxWidth: screenSize.width - 110 ),
                                  child: const Text('18 Wanstead Ave.', textAlign: TextAlign.left ,maxLines: 3, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2E3191), overflow: TextOverflow.ellipsis, ),),
                                ),
                              ],
                            ),
                            //const SizedBox( height: 5.0 ,),
                            Row(
                              children: const [
                                Text('Scarborough Oakridge, ON', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xFF2E3191)),),
                                SizedBox( width: 10.0, ),
                                Icon(Icons.map_outlined, color: Color(0xFF0BB48B), size: 32,),
                              ],
                              
                            ),
                            const Divider( height: 28,  thickness: 0.8, color: Color(0xFF0BB48B), ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Text('Listed for: ', style: TextStyle(fontSize: 16, color: Color(0xFF666597), ), ),   
                                    Text('\$1,500.000', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2E3191), ), ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric( vertical: 2, horizontal: 5.0 ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFF2E3191)),
                                  ),
                                  child: const Text('Detached', style: TextStyle(fontSize: 14, color: Color(0xFF2E3191),),),
                                ),                         
                              ],                   
                            ),
                            const Divider( height: 28,  thickness: 0.8, color: Color(0xFF0BB48B), ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [ 
                                Container(
                                  //width: 75.0,
                                  height: 35.0,
                                  decoration: const BoxDecoration(
                                    // border: Border.all(color: const Color(0xFF0BB48B))
                                    border: Border(
                                      //top: BorderSide(color: Color(0xFF0BB48B)),
                                      //bottom: BorderSide(color: Color(0xFF0BB48B)),
                                      //left: BorderSide(color: Color(0xFF0BB48B)),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.king_bed_outlined, color: Color(0xFF0BB48B), size: 30,),
                                      SizedBox(width: 5,),
                                      Text('3', style: TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), ),                                  
                                    ],
                                  ),
                                ),
                                Container(
                                  //width: 75.0,
                                  height: 35.0,
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      //top: BorderSide(color: Color(0xFF0BB48B)),
                                      //bottom: BorderSide(color: Color(0xFF0BB48B)),
                                      left: BorderSide(color: Color(0xFF0BB48B)),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox( width: 10,),
                                      Icon(Icons.shower_outlined, color: Color(0xFF0BB48B), size: 30,),
                                      SizedBox(width: 5,),
                                      Text('2+1', style: TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), ),                                  
                                    ],
                                  ),
                                ),
                                Container(
                                  //width: 75.0,
                                  height: 35.0,
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      //top: BorderSide(color: Color(0xFF0BB48B)),
                                      //bottom: BorderSide(color: Color(0xFF0BB48B)),
                                      left: BorderSide(color: Color(0xFF0BB48B)),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox( width: 10,),
                                      Icon(Icons.directions_car_filled_outlined, color: Color(0xFF0BB48B), size: 28,),
                                      SizedBox(width: 5,),
                                      Text('2', style: TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), ),                                    
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 120.0,
                                  height: 35.0,
                                  //width: 104.0,
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      //top: BorderSide(color: Color(0xFF0BB48B)),
                                      //bottom: BorderSide(color: Color(0xFF0BB48B)),
                                      left: BorderSide(color: Color(0xFF0BB48B)),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.straighten_outlined, color: Color(0xFF0BB48B), size: 24,),
                                      SizedBox(width: 5,),
                                      Text('8,900', style: TextStyle( color: Color(0xFF666597), fontWeight: FontWeight.bold, fontSize: 14, ), )                                    
                                    ],
                                  ),
                                ),                          
                              ],                          
                            ),
                          ],
                        ),
                      ),
                    ],  
                  ),

                  // OVERLAYS
                  Container(
                    //width: 310,
                    //height: 207, 
                    padding: const EdgeInsets.fromLTRB( 0, 15, 50, 0),
                    alignment: Alignment.topRight,  
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 1.0,
                          top: 2.0,
                          child: Icon(Icons.favorite_outlined, color: Colors.black26, size: 32),
                        ),
                        InkWell(
                          child: const Icon(Icons.favorite_outlined, color: Color(0xFFffffff), size: 32),
                          onTap: () {
                            //print('object');
                          },
                        )
                      ],
                    ),                  
                  ),
                  Container(
                    //width: 310,
                    //height: 207, 
                    padding: const EdgeInsets.fromLTRB( 0, 15, 10, 0),
                    alignment: Alignment.topRight,  
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 1.0,
                          top: 2.0,
                          child: Icon(Icons.filter_9_plus_outlined, color: Colors.black26, size: 32),
                        ),
                        InkWell(
                          child: const Icon(Icons.filter_9_plus_outlined, color: Color(0xFFffffff), size: 32),
                          onTap: () {
                            //Navigator.pushNamed(context, 'card_images_screen', arguments: movieMap);
                            //print('object');
                          },
                        )                              
                      ],
                    ),                          
                  ),
                  Container(
                    //width: 310,
                    height: 370,
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      child: const Image(image: AssetImage('assets/play&learn_chip_85h.png'), ),
                      onTap: () {
                        //print('object');
                      },
                    ),
                  ),
                  Container(
                    width: 170,
                    padding: const EdgeInsets.only( left: 20.0, top: 10.0, ),
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      /* style: ButtonStyle( 
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF2E3191)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(10, 0, 10, 0)),
                      ), */
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF2E3191),
                        minimumSize: const Size(140.0, 28.0),
                        padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {
                        //Navigator.pushNamed(context, 'details', arguments: movie);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.calendar_month_outlined, size: 16,),
                          SizedBox(width: 5,),
                          Text('Listed 7 days ago', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400))
                        ],
                      ),
                    )
                  ),                
      
                ],
              ),
            ),
            // MAP
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide( color: Color(0xFF0BB48B), width: 2.0 ) 
              ),
              borderOnForeground: true,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: const FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                image: AssetImage('assets/house_map.png'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox( height: 14.0, ),
            //const Divider( thickness: 0.8, color: Color(0xFF0BB48B), indent: 20.0, endIndent: 20.0, ), 
            const SizedBox( height: 8.0,),
            const DetailsExpansions(),           
          ],
        ),
      ),
    );
  }
}


class DetailsExpansions extends StatefulWidget {
  const DetailsExpansions({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsExpansions> createState() => _DetailsExpansionsState();
}

class _DetailsExpansionsState extends State<DetailsExpansions> {

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
            const Divider( thickness: 0.8, color: Color(0xFF0BB48B), indent: 20.0, endIndent: 20.0, height: 0,),
            ExpansionTile(
              tilePadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              childrenPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              title: Text(
                'Facts and Features', 
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: _openCloseIcons[0] ? const Color(0xFF2E3191) : const Color(0xFF58595B),
                ),),
              trailing: Icon(
                _openCloseIcons[0] ? Icons.remove : Icons.add,
                color: _openCloseIcons[0] ? const Color(0xFF2E3191) : const Color(0xFF58595B),
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
