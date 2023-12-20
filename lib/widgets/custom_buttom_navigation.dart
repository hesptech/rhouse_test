import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

//import 'package:flutter_black_white/providers/repliers_game.dart';
//import 'package:flutter_black_white/providers/repliers_favorites.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/search_delegate.dart';
//import 'package:flutter_black_white/utils/shared_preferences.dart';
//import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/screens/screens.dart';
import 'package:flutter_black_white/utils/authentication_singleton.dart';
import 'package:flutter_black_white/utils/enums_app.dart';

class CustomBottomNavigator extends StatefulWidget {
  const CustomBottomNavigator({ Key? key }) : super(key: key);

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {

  final loggedIn = false;
  int _selectedIndex = 0;

  static final List<String> _pages = <String>[
    '/',
    '/',
    'game_screen',
    'favorites_screen',
    LoginScreen.pathScreen,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //print(loggedIn);
      if (index == 1) {
        showSearch(context: context, delegate: InputSearchDelegate());
      } else if (index == 2) {
        Navigator.pushNamed(context, _pages[index]);
        /* if (Provider.of<FilterProvider>(context, listen: false).cardGamePriceDisplay == false) {
          Provider.of<FilterProvider>(context, listen: false).cardGamePriceDisplay = true;
          Navigator.pushNamed(context, _pages[2]);
        } else {
          Navigator.pushNamed(context, 'game_screen');
        } */
      } else if (index == 3) {
        //Provider.of<RepliersFavorites>(context, listen: false).getSelectFavorites('1');
        Navigator.pushNamed(context, _pages[index]);
      } else if (index == 4) {
        //Preferences.isLoggedIn = !Preferences.isLoggedIn;
        Navigator.pushNamed(context, _pages[4]);
        //Navigator.pop(context);
        //Navigator.restorablePopAndPushNamed(context, '/');
      } else if (index > 0) {
       if (_pages[index] == LoginScreen.pathScreen) {
          var authStatus = AuthSingleton().authStatus;
          if (authStatus == AuthStatus.authenticated) {
            Navigator.pushNamed(context, AccountScreen.pathScreen);
          } else {
            Navigator.pushNamed(context, _pages[index]);
          }
        } else {
          Navigator.pushNamed(context, _pages[index]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: kSecondaryColor,
      //selectedItemColor: const Color(0xFFe8eaf6),
      unselectedItemColor: kPrimaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 32,
      items: const <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon( Icons.home_outlined, size: 36.0, ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.search_outlined,  ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/play&learn_bottom_nav.png")),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.favorite_border_outlined,  ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.account_circle_outlined,  ),
          label: ''
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFF211f7c),
      onTap: _onItemTapped,
    );
  }
}