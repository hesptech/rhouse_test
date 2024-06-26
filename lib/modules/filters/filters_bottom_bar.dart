import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/screens/map_screen.dart';

class FiltersBottomBar extends StatefulWidget {
  final String pathScreen;
  const FiltersBottomBar({Key? key, this.pathScreen = ""}) : super(key: key);

  @override
  State<FiltersBottomBar> createState() => _FiltersBottomBarState();
}

class _FiltersBottomBarState extends State<FiltersBottomBar> {
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    return Container(
      height: 68,
      color: kSecondaryColor,
      padding: const EdgeInsets.fromLTRB(22.0, 10.0, 22.0, 0),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    FilterProvider().cleanFilter();
                    filterProvider.filterProvider = 'residential';
                    Provider.of<FilterProvider>(context, listen: false).filtersPropertyTypeHouse = [];
                    Provider.of<FilterProvider>(context, listen: false).filtersLocation = [];
                    Provider.of<FilterProvider>(context, listen: false).filtersStyleHouse = [];
                    Provider.of<FilterProvider>(context, listen: false).filtersStyleCondo = [];
                    Provider.of<FilterProvider>(context, listen: false).filtersBasement = [];
                    Provider.of<FilterProvider>(context, listen: false).filtersAmmenities = [];
                    Provider.of<FilterProvider>(context, listen: false).filtersLocationTopbts = [];

                    if (widget.pathScreen == MapScreen.pathScreen) {
                      Navigator.pushReplacementNamed(context, MapScreen.pathScreen, arguments: {'filter': "true"});
                    } else {
                      Navigator.pushNamed(context, '/');
                    }
                  });
                },
                child: const Text(
                  "CLEAR",
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              flex: 1,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: kPrimaryColor), backgroundColor: kPrimaryColor),
                onPressed: () {
                  Preferences.isFilter = true;

                  if (widget.pathScreen == MapScreen.pathScreen) {
                    // Navigator.pop(context);
                    Preferences.isFilterSubmit = true;
                    // Navigator.pushReplacementNamed(context, MapScreen.pathScreen);
                    // Navigator.pushNamed(context, MapScreen.pathScreen);
                    // Navigator.removeRoute(context, MaterialPageRoute(builder: (context) => const MapScreen()));
                    Navigator.of(context).pushNamedAndRemoveUntil(MapScreen.pathScreen, (Route<dynamic> route) => false);
                    // Navigator.of(context).popUntil(ModalRoute.withName(MapScreen.pathScreen));

                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MapScreen()),);
                  } else {
                    Navigator.pushNamed(context, 'filters_results_screen');
                  }
                },
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
