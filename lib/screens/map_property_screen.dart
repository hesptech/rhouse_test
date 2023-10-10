import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/maps/map_location_property.dart';
import 'package:flutter_black_white/providers/maplist_provider.dart';
import 'package:flutter_black_white/widgets/loadable_widget.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

///Screen showing a property on a map
class MapPropertyScreen extends StatelessWidget {
  static String pathScreen = "mapProperty_screen";

  const MapPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Listing listingArgument = _checkArguments(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Map location', style: TextStyle(fontSize: 26)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 34,
              )),
          elevation: 0,
          toolbarHeight: 60,
          centerTitle: true,
        ),
        backgroundColor: 
            listingArgument.mapCoordinates?.latitude == 0 || listingArgument.mapCoordinates?.longitude == 0
                ? Colors.white
                : null,
        body: SafeArea(
          bottom: false,
          child: LoadableWidget(
              loader: () =>
                  StyleReader(uri: kMaptilerUrl, apiKey: MapListProvider().getApiKey)
                      .read(),
              builder: (_, Style remoteTheme) => MapLocationProperty(
                    listing: listingArgument,
                    style: remoteTheme,
                  )),
        ));
  }

  Listing _checkArguments(BuildContext context) {
    try {
      final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

      return arguments["listing"] as Listing;
    } catch (e) {
      Navigator.pop(context);
      return Listing();
    }
  }
}
