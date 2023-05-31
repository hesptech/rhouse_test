import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/maps/map_residences_search.dart';
import 'package:flutter_black_white/providers/maplist_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/geolocation_app.dart';
import 'package:flutter_black_white/widgets/error_view_widget.dart';
import 'package:flutter_black_white/widgets/loadable_widget.dart';
import 'package:flutter_black_white/widgets/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';

import '../providers/filter_provider.dart';
import '../utils/connectivity_internet.dart';
import '../utils/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  static String path = "mapSearch_screen";
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    var arguments = _checkArguments(context);
    bool isFilter = arguments["filter"];

    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text('Map search', style: TextStyle(fontSize: 26)),
              SizedBox(
                width: 140,
                child: TextButton(
                    onPressed: () {
                      FilterProvider().cleanFilter();
                      Navigator.pushNamed(context, MapScreen.path, arguments: {'filter': "false", 'mlsNumber': ''});
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.replay,
                          color: Color(0XFF09B68D),
                          size: 22,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Reset Filters",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          leading: IconButton(
              onPressed: () {
                FilterProvider().cleanFilter();
                Navigator.pushNamed(context, '/');
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 34,
              )),
          toolbarHeight: 90,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Preferences.isCleanFilter = false;
                Navigator.pushNamed(context, 'filters_screen', arguments: {'screenPath': MapScreen.path});
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.tune_outlined,
                    color: isFilter ? const Color(0XFFED1C24) : Colors.white,
                    size: 35,
                  ),
                  const Text(
                    "Filters",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: FutureBuilder<bool>(
              future: ConnectivityInternet.hasConnection(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadWidget();
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return const ErrorViewWidget();
                }

                if (snapshot.data == false) {
                  return const NoInternetWidget();
                }

                return LoadableWidget(
                    loader: () => StyleReader(
                            uri: MapListProvider().getMapTilerUrl,
                            apiKey: MapListProvider().getApiKey,
                            logger: const Logger.console())
                        .read(),
                    builder: (_, Style remoteTheme) {
                      return LoadableWidget(
                          loader: () => GeolocationApp().getPosition(),
                          builder: (_, LatLng coordinates) {
                            return MapResidencesSearch(
                              style: remoteTheme,
                              isFilter: isFilter,
                              coordinates: coordinates,
                            );
                          });
                    });
              }),
        ));
  }

  Map<String, dynamic> _checkArguments(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    bool isFilter = arguments["filter"].toString() == "true" ? true : false;
    Map<String, dynamic> results = {
      'filter': isFilter,
    };

    return results;
  }
}
