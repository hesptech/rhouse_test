import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/maps/map_card_single.dart';
import 'package:flutter_black_white/widgets/maptiler_widget.dart';
import 'package:flutter_black_white/widgets/widgets.dart';
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
    return Material(
      color: Colors.transparent,

      child: Column(
        children: [
          Expanded(
            child: Stack(
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
            ),
          ),
          _mapLocation()
        ],
      ),
    );
  }

  Widget _mapLocation() {
    return Container(
      color: Colors.transparent,
      width: 450,
      child: MapCardSingle(widget.listing));
    // Center(
    //     child: Container(
    //         margin: const EdgeInsets.only(left: 20, right: 0,),            
    //         color: Colors.transparent,
    //         // height: MediaQuery.of(context).size.height * 0.90,
    //         child: MapCardSingle(widget.listing)));
            // width: MediaQuery.of(context).size.width,
    // return Container(
    //   color: Colors.transparent,
    //   child: Text("data"));
  }
}
