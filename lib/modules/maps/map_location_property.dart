import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/maps/map_card_single.dart';
import 'package:flutter_black_white/modules/maps/widgets/maptiler_widget.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/widgets/no_address_available_widget.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

///Widgete that displays and receives a configuration to display a residence on the map.
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
            coordinates?.latitude == 0 || coordinates?.longitude == 0 ? const NoAddressAvailableWidget() : _mapLocation(constraints),
            Align(alignment: Alignment.bottomCenter, child: _cardInformation(constraints)),
          ],
        );
      },
    );
  }

  Widget _cardInformation(BoxConstraints constraints) {
    double marginSize = constraints.maxWidth * 0.05;

    return Container(
      margin: EdgeInsets.all(marginSize),
      height: constraints.maxHeight * 0.40,
      
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: kPrimaryColor,
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
    );
  }
}
