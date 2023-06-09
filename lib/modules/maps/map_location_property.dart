import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/maps/map_card_single.dart';
import 'package:flutter_black_white/modules/maps/widgets/maptiler_widget.dart';
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
    var coordinates = widget.listing.mapCoordinates;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            coordinates?.latitude == null || coordinates?.longitude == null ? _notFound(constraints) : _mapLocation(constraints),
            Align(alignment: Alignment.bottomCenter, child: _cardInformation(constraints)),
          ],
        );
      },
    );
  }

  Widget _cardInformation(BoxConstraints constraints) {
    double marginSize = constraints.maxWidth * 0.05; // Ejemplo de tamaño de margen responsive

    return Container(
      margin: EdgeInsets.all(marginSize),
      height: constraints.maxHeight * 0.40,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0XFF2D368F),
        ),
      ),
      child: MapCardSingle(listing: widget.listing),
    );
  }

  Widget _mapLocation(BoxConstraints constraints) {
    return MapTilerWidget(
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
    );
  }

  Widget _notFound(BoxConstraints constraints) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: constraints.maxHeight * 0.48,
          child: const Image(
            image: AssetImage('assets/map.png'),
          ),
        ),
        const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("No maps cooordinates available", style: TextStyle(color:  Color(0XFF2D368F), fontSize: 13),))
      ],
    );
  }
}
