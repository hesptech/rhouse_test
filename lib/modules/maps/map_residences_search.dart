import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_black_white/models/response_listings.dart';
import 'package:flutter_black_white/providers/maplist_provider.dart';
import 'package:flutter_black_white/utils/geolocation_app.dart';
import 'package:flutter_black_white/widgets/loadable_widget.dart';
import 'package:flutter_black_white/widgets/maptiler_widget.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapResidencesSearch extends StatelessWidget {
  final Style style;
  final TileOffset tileOffset;

  const MapResidencesSearch({super.key, required this.style, this.tileOffset = TileOffset.DEFAULT});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<LatLng>(
        future: GeolocationApp().getPosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadWidget();
          }
          var value = snapshot.data ?? LatLng(0, 0);
          return _mapWidget(value);
        });
  }

  Widget _mapWidget(LatLng coordinates) {
    return FutureBuilder<List<Listing>>(
      future: MapListProvider().getLocationsResidences(),
      builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadWidget();
          }

          var data = snapshot.data ?? [];

        return MapTilerWidget(
            center: coordinates,          
            listCoordinates: data,
            zoom: 5,
            isMultiple: true,
            layerFactory: (context, layerMode) => VectorTileLayer(
                tileProviders: style.providers, theme: style.theme, layerMode: layerMode, tileOffset: tileOffset));
      }
    );
  }
}
