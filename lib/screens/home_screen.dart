import 'package:flutter/material.dart';
import 'package:flutter_black_white/filters/filters.dart';
import 'package:flutter_black_white/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCustom(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox( height: 15,),
            FiltersClassButtons(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigator(),
    );    
  }
}