import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/models.dart';

///Maptiler widget, used to display a list of properties or a single property on the map.
class MapTilerWidget extends StatefulWidget {
  final void Function(List<Marker> markerClusred, List<Listing> listingsSelected)? onClusterTap;
  final void Function(List<Marker> mapMarkers, List<Listing> listingsSelected)? onTapMarker;
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
  final bool loadMap;
  final List<Marker> markers;

  const MapTilerWidget(
      {super.key,
      required this.cards,
      this.onClusterTap,
      this.markers = const [],
      this.changeZoom,
      this.onTapMarker,
      this.center,
      this.zoom = 18,
      this.isMultiple = true,
      this.loadMap = false,
      this.isMiniature = false,
      this.selectedCluster = const [],
      this.listingSingle,
      this.onTapMap,
      this.listCoordinates = const []});

  @override
  State<StatefulWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapTilerWidget> {
  late final MapController _controller;
  late double _minZoom;
  late double _maxZoomList;
  late double _maxZoomsingle;
  late double _maxZoom;
  late double _zoomValue;
  late List<Marker> markers;
  late Marker markerSingle;
  late List<Marker> _selectedCluster;
  Marker? currentMarker;
  late bool _cleanMarkers;
  late List<Listing> propertiesAll;
  @override
  void initState() {
    _controller = MapController();
    propertiesAll = [];
    _cleanMarkers = true;
    _minZoom = 6;
    _maxZoomList = 15;
    _maxZoomsingle = 18;
    _maxZoom = 20;

    _zoomValue = widget.zoom;
    if (widget.isMultiple) {
      markers = [];
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
      _setMarkers();

      setState(() {
        _selectedCluster = widget.selectedCluster;
        currentMarker = widget.selectedCluster.isEmpty ? null : currentMarker;
      });
    }
    _zoomValue = _controller.zoom;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _minZoom = 6;
    _maxZoomList = 15;
    _maxZoomsingle = 18;
    _maxZoom = 20;
    _zoomValue = 0;
    markers = [];
    _selectedCluster = [];
    currentMarker = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FlutterMap(
            mapController: _controller,
            options: MapOptions(
                bounds: LatLngBounds.fromPoints([widget.center!]),
                zoom: _zoomValue,
                minZoom: _minZoom,
                maxZoom: widget.isMultiple ? _maxZoomList : _maxZoomsingle,
                keepAlive: true,
                onTap: (tapPosition, point) {
                  if (widget.onTapMap == null) {
                    return;
                  }
                  widget.onTapMap!();
                },
                onMapReady: () {
                  double latitudeAlfa = 0;

                  if (widget.isMiniature) {
                    latitudeAlfa = widget.center!.latitude;
                  } else {
                    latitudeAlfa = widget.center!.latitude - 0.0003;
                  }

                  _controller.move(LatLng(latitudeAlfa, widget.center!.longitude), _zoomValue);
                },
                interactiveFlags: widget.isMiniature
                    ? InteractiveFlag.none
                    : InteractiveFlag.drag | InteractiveFlag.flingAnimation | InteractiveFlag.pinchMove | InteractiveFlag.pinchZoom | InteractiveFlag.doubleTapZoom),
            children: [
              TileLayer(
                urlTemplate: kMaptilerUrl,
              ),
              _markers()
            ],
          ),
        ),
        widget.cards
      ],
    );
  }

  Widget _markers() {
    return MarkerClusterLayerWidget(
      key: const Key("value"),
      options: MarkerClusterLayerOptions(
        animationsOptions: const AnimationsOptions(
          centerMarkerCurves: Curves.fastOutSlowIn,
          fitBoundCurves: Curves.fastOutSlowIn,
          centerMarker: Duration.zero,
          fitBound: Duration.zero,
          spiderfy: Duration.zero,
          zoom: Duration.zero
        ),
        size: const Size(50, 50),
        maxClusterRadius: 80,
        spiderfyCluster: false,
        zoomToBoundsOnClick: false,
        fitBoundsOptions: widget.isMultiple
            ? FitBoundsOptions(padding: const EdgeInsets.all(50), maxZoom: _maxZoom)
            : FitBoundsOptions(padding: const EdgeInsets.only(top: 500), maxZoom: _maxZoom),
        markers: widget.isMultiple ? markers.toList() : [markerSingle],
        onClusterTap: (MarkerClusterNode markerClusterNode) {
          if (widget.onClusterTap == null) {
            return;
          }
          currentMarker = null;
          var keys = markerClusterNode.mapMarkers.map((marker) => ValueKey(marker.key).value).toSet();
          var filteredListings = propertiesAll.where((listing) => keys.contains(Key(listing.mlsNumber!))).toList();
          widget.onClusterTap!(markerClusterNode.mapMarkers, filteredListings);
        },
        builder: (context, markers) {
          bool isSelected = false;
          markers.where((element) => element.key == _selectedCluster[0].key);
          if (_selectedCluster.isNotEmpty) {
            isSelected = _selectedCluster.every((marker) => markers.contains(marker)) == true;
          }
          return Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !isSelected ? kPrimaryColor : kWarningColor,
              border: Border.all(
                color: !isSelected ? kSecondaryColor : Colors.white,
                width: 5.0,
              ),
            ),
            child: Center(
              child: Text(
                markers.length.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          );
        },
      ),
    );
  }

  void _setMarkers() {
    if (_cleanMarkers) {
      _cleanMarkers = false;
      markers = [];
    }

    final existingMarkerKeys = markers.map((marker) => marker.key).toSet();

    for (var item in widget.listCoordinates) {
      var key = Key(item.mlsNumber ?? "");

      if (!existingMarkerKeys.contains(key)) {
        markers.add(Marker(
          key: key,
          height: 50,
          width: 50,
          point: LatLng(item.mapCoordinates!.latitude, item.mapCoordinates!.longitude),
          builder: (ctx) {
            bool isSelected = false;
            if (currentMarker != null && currentMarker!.key == key) {
              isSelected = true;
            }

            return GestureDetector(
              onTap: () {
                if (widget.onTapMarker == null) {
                  return;
                }

                var markerItem = markers.where((element) => element.key == key).toList();

                if (markerItem.isNotEmpty) {
                  setState(() {
                    currentMarker = markerItem.first; // asigna el marcador seleccionado
                  });

                  var keys = markerItem.map((marker) => ValueKey(marker.key).value).toSet();
                  var filteredListings = propertiesAll.where((listing) => keys.contains(Key(listing.mlsNumber!))).toList();

                  widget.onTapMarker!(markerItem, filteredListings);
                }
              },
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: !isSelected ? kPrimaryColor : kWarningColor,
                  border: Border.all(
                    color: !isSelected ? kSecondaryColor : Colors.white,
                    width: 5.0,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ));
      }

      var propertyItem = propertiesAll.singleWhere(
        (element) => element.mlsNumber == item.mlsNumber,
        orElse: () => Listing(mlsNumber: ""),
      );

      if (propertyItem.mlsNumber == null || propertyItem.mlsNumber == "") {
        propertiesAll.add(item);
      }
    }
  }

  void _setMarker() {
    var listing = widget.listingSingle ?? Listing();
    var mapCoordinates = listing.mapCoordinates ?? MapCoordinates(point: "", latitude: 0, longitude: 0);

    markerSingle = Marker(
        key: Key(listing.mlsNumber ?? ""),
        height: widget.isMiniature ? 50 : 60,
        width: widget.isMiniature ? 50 : 60,
        anchorPos: AnchorPos.align(AnchorAlign.top),
        point: LatLng(mapCoordinates.latitude, mapCoordinates.longitude),
        builder: (ctx) {
          return GestureDetector(
              onTap: () {
                _zoomValue = widget.zoom;
                _controller.move(widget.center!, _zoomValue);
              },
              child: Icon(
                Icons.location_on_outlined,
                color: widget.isMiniature ? kPrimaryColor : kSecondaryColor,
                size: widget.isMiniature ? 50 : 70,
              ));
        });
  }

}
