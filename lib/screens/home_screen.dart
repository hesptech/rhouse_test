import 'package:flutter/material.dart';
import 'package:flutter_black_white/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCustom(),
      body: ListView(
        children: const <Widget>[

          SizedBox(height: 8),
          Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigator(),
    );    
  }
}