import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import '../models/models.dart';

class MapTilerWidget extends StatefulWidget {
  final VectorTileLayer Function(BuildContext, VectorTileLayerMode mode) layerFactory;
  final LatLng? center;
  final List<Listing> listCoordinates;
  final double zoom;
  final bool isMultiple;

  const MapTilerWidget(
      {super.key,
      required this.layerFactory,
      this.center,
      this.zoom = 18,
      this.isMultiple = true,
      this.listCoordinates = const []});

  @override
  State<StatefulWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapTilerWidget> {
  final MapController _controller = MapController();
  final _layerMode = VectorTileLayerMode.raster;
  final double _minZoom = 6;
  final double _maxZoom = 15;
  late double _zoomValue;
  final List<Marker> markers = [];

  @override
  void initState() {
    _zoomValue = widget.zoom;
    if (widget.isMultiple) {
      _setMarkers();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Stack(children: [
        FlutterMap(
          mapController: _controller,
          options: MapOptions(
              bounds: LatLngBounds.fromPoints([widget.center!]),
              center: widget.center!,
              zoom: _zoomValue,
              minZoom: _minZoom,
              maxZoom: _maxZoom,
              onMapReady: () {
                _controller.move(widget.center!, _zoomValue);
              },
              onMapEvent: (p0) {
                print("ZOOM: ${p0.zoom}");
              },
              interactiveFlags: InteractiveFlag.drag |
                  InteractiveFlag.flingAnimation |
                  InteractiveFlag.pinchMove |
                  InteractiveFlag.pinchZoom |
                  InteractiveFlag.doubleTapZoom),
          children: [
            widget.layerFactory(context, _layerMode),
            _markers(),
          ],
        ),
      ])),
    ]);
  }

  Widget _markers() {
    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        maxClusterRadius: 80,
        size: const Size(50, 50),
        anchor: AnchorPos.align(AnchorAlign.center),
        fitBoundsOptions: FitBoundsOptions(padding: const EdgeInsets.all(50), maxZoom: _maxZoom),
        spiderfyCluster: false,        
        markers: markers,
        builder: (context, markers) {
          return Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0XFF214497),
              border: Border.all(
                color: const Color(0XFF09B68D),
                width: 5.0,
              ),
            ),
            child: Center(
              child: Text(
                markers.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  void _setMarkers() {
    for (var item in widget.listCoordinates) {
      markers.add(
        Marker(
          height: 30,
          width: 30,          
          point: LatLng(item.mapCoordinates!.latitude, item.mapCoordinates!.longitude),
          builder: (ctx) =>  const Icon(Icons.location_on_outlined, color:Color(0XFF02B68C), size: 50),
        ),
      );
    }
  }
}
