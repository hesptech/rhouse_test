import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import '../models/models.dart';

class MapTilerWidget extends StatefulWidget {
  final VectorTileLayer Function(BuildContext, VectorTileLayerMode mode) layerFactory;
  final void Function(MarkerClusterNode markerClusred)? onClusterTap;
  final void Function(List<Marker> mapMarkers)? onTapMarker;
  final void Function(MapEvent mapEvent)? changeZoom;
  final Widget? cards;
  final LatLng? center;
  final List<Listing> listCoordinates;
  final List<Marker> selectedCluster;
  final double zoom;
  final bool isMultiple;
  final bool isCloseCards;

  const MapTilerWidget(
      {super.key,
      required this.layerFactory,
      this.onClusterTap,
      this.changeZoom,
      this.onTapMarker,
      this.cards,
      this.center,
      this.zoom = 18,
      this.isMultiple = true,
      this.isCloseCards = false,
      this.selectedCluster = const [],
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
  late List<Marker> _selectedCluster;
  Marker? currentMarker;


  @override
  void initState() {
    _zoomValue = widget.zoom;
    if (widget.isMultiple) {
      _setMarkers();

      _selectedCluster = widget.selectedCluster;

      _controller.mapEventStream.listen((event) {
        if (widget.changeZoom == null) {
          return;
        }

        if (_zoomValue != event.zoom) {
          _zoomValue = event.zoom;
          widget.changeZoom!(event);
          setState(() {
            currentMarker = null;            
          });
        }
      });
    }


    super.initState();
  }

  @override
  void didUpdateWidget(MapTilerWidget oldWidget) {
    if (widget.isMultiple) {
      setState(() {
        _selectedCluster = widget.selectedCluster;
        currentMarker = widget.selectedCluster.isEmpty ? null : currentMarker;
      });
    }
    _zoomValue =  _controller.zoom;
    super.didUpdateWidget(oldWidget);
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
      widget.isMultiple ? widget.cards! : Container()
    ]);
  }

  Widget _markers() {
    return MarkerClusterLayerWidget(            
      options: MarkerClusterLayerOptions(
        size: const Size(50, 50),
        maxClusterRadius: 80,     
        anchor: AnchorPos.align(AnchorAlign.center),
        fitBoundsOptions: FitBoundsOptions(padding: const EdgeInsets.all(50), maxZoom: _maxZoom),
        spiderfyCluster: false,
        markers: markers,
        zoomToBoundsOnClick: false,
        onClusterTap: (MarkerClusterNode markerClusterNode) {
          if (widget.onClusterTap == null) {
            return;
          }
          currentMarker = null;
          widget.onClusterTap!(markerClusterNode);
        },
        builder: (context, markers) {
          bool isSelected = false;

          if (_selectedCluster.isNotEmpty) {
            isSelected = _selectedCluster.every((marker) => markers.contains(marker)) == true;
          }
          return Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !isSelected ? const Color(0XFF214497) : const Color(0XFFED1C24),
              border: Border.all(
                color: !isSelected ? const Color(0XFF09B68D) : Colors.white,
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
          key: Key(item.mlsNumber ?? ""),
          height: 30,
          width: 30,

          point: LatLng(item.mapCoordinates!.latitude, item.mapCoordinates!.longitude),
          builder: (ctx) {
            var color = const Color(0XFF02B68C);
            if (currentMarker != null) {
              if (currentMarker!.key == Key(item.mlsNumber ?? "")) {
                color = Colors.red;                
              }
            }
            return GestureDetector(
                onTap: () {
                  if (widget.onTapMarker == null) {
                    return;
                  }

                  var keyItem = Key(item.mlsNumber ?? "");

                  var markerItem = markers.where((element) => element.key == keyItem).toList();

                  if (markerItem.isNotEmpty) {
                    setState(() {
                      currentMarker = markerItem.first; // asigna el marcador seleccionado
                    });

                    widget.onTapMarker!(markerItem);
                  }
                },
                child: Icon(Icons.location_on_outlined, color: color, size: 50));
          },
        ),
      );
    }
  }



}
