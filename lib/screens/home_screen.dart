import 'package:flutter/material.dart';
import 'package:flutter_black_white/filters/filters.dart';
import 'package:flutter_black_white/widgets/widgets.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox( height: 15,),
            const FiltersClassButtons(),
            Text(Preferences.locationLat.toString()),
            Text(Preferences.locationLng.toString()),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigator(),
    );    
  }
}