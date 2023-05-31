import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/maps/map_card_single.dart';
import 'package:flutter_black_white/widgets/maptiler_widget.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapLocationProperty extends StatefulWidget {
  final Style style;
  final TileOffset tileOffset;
  final Listing listing;

  const MapLocationProperty(
      {super.key, required this.style, required this.listing, this.tileOffset = TileOffset.DEFAULT});

  @override
  State<MapLocationProperty> createState() => _MapLocationPropertyState();
}

class _MapLocationPropertyState extends State<MapLocationProperty> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapTilerWidget(
            center: LatLng(widget.listing.mapCoordinates!.latitude, widget.listing.mapCoordinates!.longitude),
            listingSingle: widget.listing,
            cards: _mapLocation(),
            zoom: 20,
            isMultiple: false,
            layerFactory: (context, layerMode) => VectorTileLayer(
                tileProviders: widget.style.providers,
                theme: widget.style.theme,
                layerMode: layerMode,
                tileOffset: widget.tileOffset)),
      ],
    );
  }

  Widget _mapLocation() {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        color: Colors.white,
        child: MapCardSingle(widget.listing));
  }
}
