import 'package:cancellation_token_http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/maps/map_residences_search.dart';
import 'package:flutter_black_white/modules/maps/utils/geolocation_app.dart';
import 'package:flutter_black_white/providers/maplist_provider.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/widgets/error_view_widget.dart';
import 'package:flutter_black_white/widgets/loadable_widget.dart';
import 'package:flutter_black_white/widgets/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:cancellation_token_http/http.dart' as http;

import '../providers/filter_provider.dart';
import '../utils/connectivity_internet.dart';
import '../utils/shared_preferences.dart';

///Screen showing the property list in a map[a
class MapScreen extends StatefulWidget {
  static String pathScreen = "mapSearch_screen";
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late bool isFilter = false;
  late MapListProvider _mapListProvider;
  bool isEnable = false;
  late final CancellationToken tokenHttpCancelation;

  @override
  void initState() {
    tokenHttpCancelation = http.CancellationToken();
    isFilter = Preferences.isFilter;

    _mapListProvider = Provider.of<MapListProvider>(context, listen: false);
    _mapListProvider.initData();
    super.initState();
  }

  @override
  void dispose() {
    final isRefresh = Preferences.isFilterSubmit;

    if (!isRefresh) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapListProvider.closeView();
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Preferences.isFilterSubmit = false;
        tokenHttpCancelation.cancel();
        Navigator.pushReplacementNamed(context, "/");
        return true;
      },
      child: Scaffold(
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
                      onPressed: () async {
                        tokenHttpCancelation.cancel();
                        FilterProvider().cleanFilter();
                        Preferences.isFilterSubmit = true;
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          useSafeArea: true,
                          builder: (BuildContext context) {
                            return WillPopScope(
                                onWillPop: () async => false,
                                child: const AlertDialog(
                                  elevation: 0,
                                  content: SizedBox(height: 120, child: LoadWidget()),
                                ));
                          },
                        );

                        await _mapListProvider.closeAsync();

                        await Future.delayed(
                          const Duration(milliseconds: 400),
                          () {
                            Navigator.of(context).pushNamedAndRemoveUntil(MapScreen.pathScreen, (Route<dynamic> route) => false);
                          },
                        );
                      },
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.replay,
                            color: kSecondaryColor,
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
                  tokenHttpCancelation.cancel();
                  Preferences.isFilterSubmit = false;
                  Navigator.of(context).pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
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
                  Navigator.pushNamed(context, 'filters_screen', arguments: {'screenPath': MapScreen.pathScreen});
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.tune_outlined,
                      color: isFilter ? kWarningColor : Colors.white,
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
                      loader: () => GeolocationApp().getPosition(),
                      builder: (_, LatLng coordinates) {
                        return MapResidencesSearch(mapListProvider: _mapListProvider, coordinates: coordinates, tokenHttpCancelation: tokenHttpCancelation);
                      });
                }),
          )),
    );
  }
}
