import 'package:flutter/material.dart';
import 'package:flutter_black_white/screens/map_screen.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/search_delegate.dart';
import 'package:flutter_black_white/modules/maps/utils/geolocation_app.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const loggedIn = true;

    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Image(
                        image: AssetImage('assets/logos/r_logo_100x30.png'),
                      ),
                      //const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'game_welcome_screen');
                        },
                        child: const Image(
                          image: AssetImage('assets/logos/play&learn_logo100x30.png'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            /* onTap: () => displayDialog( context ),
                            child: const Image(image: AssetImage('assets/logos/play&learn_logo108x37.png'),) */
                            onTap: () {
                              GeolocationApp().requestLocalization().then((value) {
                                _goToMapSearch(context);
                              }, onError: (value) {
                                _dialogGeolocation(context);
                              });
                            },
                            //child: const Icon( Icons.map_outlined, color: kSecondaryColor, size: 26.0,),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.map_outlined,
                                  color: kSecondaryColor,
                                  size: 30.0,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  'Search by map',
                                  style:
                                      TextStyle(color: Colors.white54, fontSize: 12.0, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          //const Text('Search by map', style: TextStyle(color: Colors.white54, fontSize: 12.0, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      GestureDetector(
                        /* onTap: () => displayDialog( context ),
                        child: const Image(image: AssetImage('assets/logos/play&learn_logo108x37.png'),) */
                        onTap: () {
                          Navigator.pushNamed(context, 'filters_screen');
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Filters',
                              style:
                                  TextStyle(color: Colors.white54, fontSize: 12.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5.0,),
                            Icon(
                              Icons.tune_outlined,
                              color: kSecondaryColor,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      showSearch(context: context, delegate: InputSearchDelegate());
                      if (loggedIn == true) {
                        //showSearch(context: context, delegate: MovieSearchDelegate());
                      } else {
                        //Navigator.restorablePopAndPushNamed(context, '/');
                      }
                    },
                    child: const TextField(
                      readOnly: true,
                      style: TextStyle(color: Color(0xFF58595B)),
                      //initialValue: 'Address, Street Name or Listing#....',
                      decoration: InputDecoration(
                        labelText: 'Address, Street Name or Listing#....',
                        constraints: BoxConstraints(maxHeight: 38.0),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: Icon(
                          Icons.search_outlined,
                          color: kPrimaryColor,
                          size: 30.0,
                        ),
                        enabled: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 5,
              color: kSecondaryColor,
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _dialogGeolocation(context) async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              elevation: 2,
              content: const SizedBox(
                width: 100,
                height: 120,
                child: Center(
                  child: SingleChildScrollView(
                    child: Text("Location permissions are necessary to provide you with a better experience"),
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () async {
                      GeolocationApp.openSettingsGeolocation();
                    },
                    child: const Text("Settings")),
                TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      _goToMapSearch(context);
                    },
                    child: const Text("Ok")),
              ]);
        });
  }

  void _goToMapSearch(BuildContext context) {
    Navigator.pushNamed(context, MapScreen.pathScreen, arguments: {'filter': "false"});
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
  // *default height: kToolbarHeight
}
