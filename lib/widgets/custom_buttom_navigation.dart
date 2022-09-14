import 'package:flutter/material.dart';

class CustomBottomNavigator extends StatefulWidget {
  const CustomBottomNavigator({ Key? key }) : super(key: key);

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {

  final loggedIn = false;
  final int _selectedIndex = 0;

  static const List<String> _pages = <String>[
    '/',
    'login_page_screen',
    '/',
    '/',
    'login_screen',
    'login_account_screen',
  ];

  void _onItemTapped(int index) {
    setState(() {
      //_selectedIndex = index;
      //print(loggedIn);
      if ( index == 4 && loggedIn ) {
        Navigator.pushNamed(context, _pages[5]);
        //Navigator.pop(context);
        //Navigator.restorablePopAndPushNamed(context, '/');
      } else if (index > 0) {
        Navigator.pushNamed(context, _pages[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF0BB48B),
      //selectedItemColor: const Color(0xFFe8eaf6),
      unselectedItemColor: const Color.fromRGBO(33, 31, 124, 0.5),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 32,
      items: const <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon( Icons.home_rounded,  ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.search_outlined,  ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.add_box_outlined,  ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.favorite_border_outlined,  ),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.person_outline_outlined,  ),
          label: ''
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFF211f7c),
      onTap: _onItemTapped,
    );
  }
}