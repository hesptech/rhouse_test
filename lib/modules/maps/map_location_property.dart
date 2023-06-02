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

  const MapLocationProperty({
    Key? key,
    required this.style,
    required this.listing,
    this.tileOffset = TileOffset.DEFAULT,
  }) : super(key: key);

  @override
  State<MapLocationProperty> createState() => _MapLocationPropertyState();
}

class _MapLocationPropertyState extends State<MapLocationProperty> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            MapTilerWidget(
              center: LatLng(
                widget.listing.mapCoordinates!.latitude,
                widget.listing.mapCoordinates!.longitude,
              ),
              listingSingle: widget.listing,
              cards: Container(),
              zoom: 20,
              isMultiple: false,
              layerFactory: (context, layerMode) => VectorTileLayer(
                tileProviders: widget.style.providers,
                theme: widget.style.theme,
                layerMode: layerMode,
                tileOffset: widget.tileOffset,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _mapLocation(constraints)),
          ],
        );
      },
    );
  }

  Widget _mapLocation(BoxConstraints constraints) {
    double marginSize = constraints.maxWidth * 0.05; // Ejemplo de tamaño de margen responsive

    return Container(
      margin: EdgeInsets.all(marginSize),
      height: constraints.maxHeight * 0.40,
      padding: const EdgeInsets.all(0),
      // width: constraints.maxWidth * 0.85,
      // padding: const EdgeInsets.all(20),      
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0XFF2D368F),),
      ),
      child: MapCardSingle(listing: widget.listing),
    );
  }
}
