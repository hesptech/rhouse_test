import 'package:flutter/material.dart';
import 'package:flutter_black_white/screens/map_screen.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';
import 'package:flutter_black_white/modules/filters/filters.dart';


class FiltersScreen extends StatelessWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var pathArgument = _checkArguments(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (pathArgument == MapScreen.pathScreen) {
              if (Preferences.isCleanFilter) {
                Navigator.pushNamed(context, MapScreen.pathScreen, arguments: {'filter': "false", 'mlsNumber': ''});
                Preferences.isCleanFilter = false;
              } else {
                Navigator.of(context).pop();
              }
            } else {
              Navigator.pushNamed(context, '/');
            }
          },
          icon: const Icon(Icons.close_outlined),
        ),
        title: const Text('Personalize Listing'),
      ),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: 5,
                color: kSecondaryColor,
              ),
              const FiltersPriceSlider(),
              const FiltersClassIconBt(),
              const SizedBox(
                height: 28.0,
              ),
              const GreenDivider(),
              const FiltersPropertyType(),
              const GreenDivider(),
              pathArgument != MapScreen.pathScreen ? const FiltersLocation() : Container(),
              const GreenDivider(),
              const FiltersBathbedpark(),
              const FiltersMore(),
            ],
          ),
        );
      }),
      bottomNavigationBar: FiltersBottomBar(pathScreen: pathArgument),
    );
  }

  String _checkArguments(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    return arguments["screenPath"].toString() == MapScreen.pathScreen ? MapScreen.pathScreen : "/";
    
  }
}
