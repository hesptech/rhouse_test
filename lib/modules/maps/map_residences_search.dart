import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_black_white/modules/maps/map_card_small.dart';
import 'package:flutter_black_white/providers/maplist_provider.dart';
import 'package:flutter_black_white/modules/maps/widgets/maptiler_widget.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

///Widgete that receives a configuration to display the list of residences and maps.
class MapResidencesSearch extends StatefulWidget {
  final Style style;
  final TileOffset tileOffset;
  final LatLng coordinates;

  const MapResidencesSearch(
      {super.key,
      required this.style,
      required this.coordinates,
      this.tileOffset = TileOffset.DEFAULT});

  @override
  State<MapResidencesSearch> createState() => _MapResidencesSearchState();
}

class _MapResidencesSearchState extends State<MapResidencesSearch> {
  late List<Marker> markersList;
  late MapListProvider _mapListProvider;

  @override
  void initState() {
    markersList = [];
    _mapListProvider = Provider.of<MapListProvider>(context, listen: false);
    MapListProvider.intiConfig();
    _mapListProvider.getLocationsResidences(widget.coordinates);
    super.initState();
  }

  @override
  void dispose() {
    markersList = [];
    _mapListProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _mapListProvider.listingSelected = [];
        
        return true;
      },
      child: Stack(
        children: [
          _mapTilerList(context),
       _mapListProvider.loadMap ?   const LinearProgressIndicator(
            backgroundColor: kWarningColor,
            valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
          ) : Container(),
        ],
      ),
    );
  }

  Widget _mapTilerList(BuildContext context) {
    if (markersList.isEmpty) {
      markersList = Provider.of<MapListProvider>(context).selectedCluster;
    }

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double screenHeight = constraints.maxHeight;
      double cardHeight = screenHeight * 0.25;

      return Consumer<MapListProvider>(builder: (context, mapListProvider, _) {
        return MapTilerWidget(
            center: widget.coordinates,
            listCoordinates: mapListProvider.listingMaps,
            loadMap: mapListProvider.loadMap,
            selectedCluster: markersList,
            cards: _scrollListing(context, cardHeight),
            onClusterTap: (markerClusred) {
              onTapMarkers(markerClusred.mapMarkers, context);
            },
            onTapMarker: (mapMarkers) {
              onTapMarkers(mapMarkers, context);
            },
            changeZoom: (mapEvent) {
              _mapListProvider.selectedCluster = [];
              markersList = [];
            },
            zoom: 10,
            isMultiple: true,
            layerFactory: (context, layerMode) => VectorTileLayer(
                tileProviders: widget.style.providers,
                theme: widget.style.theme,
                layerMode: layerMode,
                tileOffset: widget.tileOffset));
      });
    });
  }

  void onTapMarkers(List<Marker> mapMarkers, BuildContext context) async {
    _mapListProvider.getFilterListings(mapMarkers);
    _mapListProvider.selectedCluster = mapMarkers;
    markersList = [];
  }

  Widget _scrollListing(BuildContext context, double cardHeight) {
    var providerMapList = Provider.of<MapListProvider>(context);

    return Visibility(
      visible: markersList.isNotEmpty,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          width: double.infinity,
          height: cardHeight * 1.5,
          color: kSecondaryColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 15, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${providerMapList.listingSelected.length} listings in total",
                        style: const TextStyle(color: Colors.white, fontSize: 14.8),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {
                          _mapListProvider.selectedCluster = [];
                          markersList = [];
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  flex: 3,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,
                      itemCount: providerMapList.listingSelected.length,
                      itemBuilder: (_, index) {
                        return FittedBox(
                          alignment: Alignment.topCenter,
                          fit: BoxFit.scaleDown,
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            width: 320,
                            height: 150,
                            margin: const EdgeInsets.only(right: 8),
                            child: MapCardSmall(providerMapList.listingSelected[index]),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
