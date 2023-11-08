import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_black_white/models/response_listings.dart';
import 'package:flutter_black_white/modules/maps/map_card_small.dart';
import 'package:flutter_black_white/providers/maplist_provider.dart';
import 'package:flutter_black_white/modules/maps/widgets/maptiler_widget.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

///Widgete that receives a configuration to display the list of residences and maps.
class MapResidencesSearch extends StatefulWidget {
  final LatLng coordinates;
  final MapListProvider mapListProvider;

  const MapResidencesSearch({super.key, required this.coordinates, required this.mapListProvider});

  @override
  State<MapResidencesSearch> createState() => _MapResidencesSearchState();
}

class _MapResidencesSearchState extends State<MapResidencesSearch> {
  late List<Marker> markersList;
  late List<Listing> coordinatesMarkers;

  @override
  void initState() {
    markersList = [];
    coordinatesMarkers = [];
    widget.mapListProvider.getLocationsResidences(widget.coordinates);
    super.initState();
  }

  @override
  void dispose() {
    markersList = [];
    // widget.mapListProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.mapListProvider.listingSelected = [];

        return true;
      },
      child: Stack(
        children: [
          _mapTilerList(context),
          widget.mapListProvider.loadMap
              ? const LinearProgressIndicator(
                  backgroundColor: kWarningColor,
                  valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
                )
              : Container(),
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

      return StreamBuilder<List<Listing>>(
        initialData: const [],
        stream: widget.mapListProvider.listingStreams,
        builder: (context, snapshot) {
          return Consumer<MapListProvider>(builder: (context, mapListProvider, _) {
            return MapTilerWidget(
                key: const Key("value"),
                center: widget.coordinates,
                listCoordinates: snapshot.hasData ? snapshot.data! : [],
                selectedCluster: markersList,
                cards: _scrollListing(context, cardHeight),
                onClusterTap: (markerClusred, List<Listing> listingSelected) {
                  onTapMarkers(markerClusred, listingSelected);
                },
                onTapMarker: (mapMarkers, listingSelected) {
                  onTapMarkers(mapMarkers, listingSelected);
                },
                changeZoom: (mapEvent) {
                  widget.mapListProvider.selectedCluster = [];
                  markersList = [];
                },
                zoom: 10,
                isMultiple: true);
          });
        }
      );
    });
  }

  void onTapMarkers(List<Marker> mapMarkers, List<Listing> listingSelected) async {
    widget.mapListProvider.getFilterListings(listingSelected);
    widget.mapListProvider.selectedCluster = mapMarkers;
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
                          widget.mapListProvider.selectedCluster = [];
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
