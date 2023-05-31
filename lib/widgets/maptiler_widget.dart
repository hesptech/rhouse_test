import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
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
  final void Function()? onTapMap;
  final Widget cards;
  final LatLng? center;
  final List<Listing> listCoordinates;
  final Listing? listingSingle;
  final List<Marker> selectedCluster;
  final double zoom;
  final bool isMultiple;
  final bool isMiniature;
  final bool isCloseCards;

  const MapTilerWidget(
      {super.key,
      required this.layerFactory,
      required this.cards,
      this.onClusterTap,
      this.changeZoom,
      this.onTapMarker,
      this.center,
      this.zoom = 18,
      this.isMultiple = true,
      this.isCloseCards = false,
      this.isMiniature = false,
      this.selectedCluster = const [],
      this.listingSingle,
      this.onTapMap,
      this.listCoordinates = const []});

  @override
  State<StatefulWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapTilerWidget> {
  final MapController _controller = MapController();
  final _layerMode = VectorTileLayerMode.raster;
  final double _minZoom = 6;
  final double _maxZoomList = 15;
  final double _maxZoomsingle = 18;
  final double _maxZoom = 20;
  late double _zoomValue;
  final List<Marker> markers = [];
  late Marker markerSingle;
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
    } else {
      _setMarker();
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
    _zoomValue = _controller.zoom;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // return Stack(children: [
    //   FlutterMap(
    //     mapController: _controller,
    //     options: MapOptions(
    //         bounds: LatLngBounds.fromPoints([widget.center!]),
    //         center: widget.center!,
    //         zoom: _zoomValue,
    //         minZoom: _minZoom,
    //         onTap: (tapPosition, point) {
    //           if (widget.onTapMap == null) {
    //             return;
    //           }
    //           widget.onTapMap!();
    //         },
    //         maxZoom: widget.isMultiple ? _maxZoomList : _maxZoomsingle,
    //         onMapReady: () {
    //           _controller.move(widget.center!, _zoomValue);

    //           // _controller.latLngToScreenPoint(widget.center!);
    //         },
    //         interactiveFlags: !widget.isMiniature ? InteractiveFlag.drag |
    //             InteractiveFlag.flingAnimation |
    //             InteractiveFlag.pinchMove |
    //             InteractiveFlag.pinchZoom |
    //             InteractiveFlag.doubleTapZoom : InteractiveFlag.none),
    //     children: [widget.layerFactory(context, _layerMode), _markers()],
    //   ),
    //   Align(alignment: Alignment.bottomCenter, child: widget.cards)
    // ]);

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
              onTap: (tapPosition, point) {
                if (widget.onTapMap == null) {
                  return;
                }

                widget.onTapMap!();
              },
              maxZoom: widget.isMultiple ? _maxZoomList : _maxZoomsingle,
              onMapReady: () {
                _controller.move(widget.center!, _zoomValue);
              },
              interactiveFlags: widget.isMiniature
                  ? InteractiveFlag.none
                  : InteractiveFlag.drag |
                      InteractiveFlag.flingAnimation |
                      InteractiveFlag.pinchMove |
                      InteractiveFlag.pinchZoom |
                      InteractiveFlag.doubleTapZoom),
          children: [widget.layerFactory(context, _layerMode), _markers()],
        ),
        // widget.cards
      ])),
      widget.cards
    ]);
  }

  Widget _markers() {
    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        size: const Size(50, 50),
        maxClusterRadius: 80,
        anchor: AnchorPos.align(AnchorAlign.center),
        fitBoundsOptions: widget.isMultiple
            ? FitBoundsOptions(padding: const EdgeInsets.all(50), maxZoom: _maxZoom)
            : FitBoundsOptions(padding: const EdgeInsets.only(top: 500), maxZoom: _maxZoom),
        spiderfyCluster: false,
        zoomToBoundsOnClick: false,
        markers: widget.isMultiple ? markers : [markerSingle],
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

  void _setMarker() {
    var listing = widget.listingSingle ?? Listing();
    markerSingle = Marker(
        key: Key(listing.mlsNumber ?? ""),
        height: 50,
        width: 50,
        point: LatLng(listing.mapCoordinates!.latitude, listing.mapCoordinates!.longitude),
        anchorPos: AnchorPos.align(AnchorAlign.top),
        builder: (ctx) {
          return GestureDetector(
              onTap: () {
                _zoomValue = widget.zoom;
                _controller.move(widget.center!, _zoomValue);
              },
              child: Icon(Icons.location_on_outlined,
                  color: widget.isMiniature ? kPrimaryColor : const Color(0XFF02B68C),
                  size: widget.isMiniature ? 50 : 80));
        });
  }
}
