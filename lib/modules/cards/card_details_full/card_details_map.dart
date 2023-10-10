import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/response_listings.dart';
import 'package:flutter_black_white/providers/maplist_provider.dart';
import 'package:flutter_black_white/screens/map_property_screen.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/modules/maps/widgets/maptiler_widget.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class CardDetailsMap extends StatelessWidget {
  final Listing listing;
  const CardDetailsMap({Key? key, required this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), side: const BorderSide(color: kSecondaryColor, width: 2.0)),
      borderOnForeground: true,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: FutureBuilder<Style>(
            future: StyleReader(
                    uri: kMaptilerUrl,
                    apiKey: MapListProvider().getApiKey)
                .read(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Column(children: [
                  Expanded(child: Container()),
                  const Center(child: CircularProgressIndicator()),
                  Expanded(child: Container())
                ]));
              }

              return _mapMiniature(snapshot.data!, context);
            })),
      ),
    );
  }

  Widget _mapMiniature(Style style, BuildContext context) {
    TileOffset tileOffset = TileOffset.DEFAULT;
    return SizedBox(
      width: 200,
      height: 300,
      child: MapTilerWidget(
          center: LatLng(listing.mapCoordinates!.latitude, listing.mapCoordinates!.longitude),
          listingSingle: listing,
          cards: Container(),
          isMiniature: true,
          zoom: 15,
          isMultiple: false,
          onTapMap: () {
            Navigator.pushNamed(context, MapPropertyScreen.pathScreen, arguments: {'listing': listing});
          },
          layerFactory: (context, layerMode) => VectorTileLayer(
              tileProviders: style.providers, theme: style.theme, layerMode: layerMode, tileOffset: tileOffset)),
    );
  }
}
