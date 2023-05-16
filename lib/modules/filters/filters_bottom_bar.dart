import 'package:flutter/material.dart';
import 'package:flutter_black_white/screens/map_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';

class FiltersBottomBar extends StatefulWidget {
  final String pathScreen;
  const FiltersBottomBar({Key? key, this.pathScreen = ""}) : super(key: key);

  @override
  State<FiltersBottomBar> createState() => _FiltersBottomBarState();
}

class _FiltersBottomBarState extends State<FiltersBottomBar> {
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>( context );

    return Container(
      height: 75,
      color: kSecondaryColor,
      padding: const EdgeInsets.fromLTRB(22.0, 14.0, 22.0, 0),
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

                    if (widget.pathScreen == MapScreen.path) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'filters_screen', arguments: {'screenPath': MapScreen.path});
                    } else {
                      Navigator.pushNamed(context, 'filters_screen');
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
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: kPrimaryColor), backgroundColor: kPrimaryColor),
                onPressed: () {
                  if (widget.pathScreen == MapScreen.path) {
                    Navigator.pushNamed(context, MapScreen.path, arguments: {'filter': "true", 'mlsNumber': ''});
                  } else {
                    Navigator.pushNamed(context, 'filters_results_screen', arguments: 'Filtered results');
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
