import 'package:cancellation_token_http/http.dart';
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
  final CancellationToken tokenHttpCancelation;

  const MapResidencesSearch({super.key, required this.coordinates, required this.mapListProvider, required this.tokenHttpCancelation});

  @override
  State<MapResidencesSearch> createState() => _MapResidencesSearchState();
}

class _MapResidencesSearchState extends State<MapResidencesSearch> {
  late List<Marker> markersList;
  late List<Listing> coordinatesMarkers;
  late final ScrollController _scrollController;

  // late MapListProvider widget.mapListProvider;
  bool isLoading = true;

  @override
  void initState() {
    _scrollController = ScrollController();
    markersList = [];
    coordinatesMarkers = [];
    // _mapListProvider = context.read<MapListProvider>();
    // widget.mapListProvider.initData();

    widget.mapListProvider.getLocationsResidences(widget.coordinates, widget.tokenHttpCancelation);
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.mapListProvider.closeAsync();
        widget.mapListProvider.listingSelected = [];

        return true;
      },
      child: Stack(
        children: [
          _mapTilerList(context),
          getIsLoad()
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
            final List<Listing> listings = snapshot.hasData ? snapshot.data! : [];
            return _mapBuildMap(listings, context, cardHeight);
          });
    });
  }

  MapTilerWidget _mapBuildMap(List<Listing> listings, BuildContext context, double cardHeight) {
    return MapTilerWidget(
        key: const Key("MapTiler"),
        center: widget.coordinates,
        isLoading: isLoading,
        listCoordinates: listings,
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
  }

  void onTapMarkers(List<Marker> mapMarkers, List<Listing> listingSelected) async {
    widget.mapListProvider.getFilterListings(listingSelected);
    widget.mapListProvider.selectedCluster = mapMarkers;
    markersList = [];


    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }

  }

  Widget _scrollListing(BuildContext context, double cardHeight) {
    if (markersList.isEmpty) {
      widget.mapListProvider.listingSelected = [];
    }

    final List<Listing> listingSelected = Provider.of<MapListProvider>(context).listingSelected;

    return Visibility(
      visible: listingSelected.isNotEmpty,
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
                        "${listingSelected.length} listings in total",
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
                          // context.watch<MapListProvider>().selectedCluster = [];
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
                      controller: _scrollController,
                      padding: const EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,
                      itemCount: listingSelected.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return FittedBox(
                          alignment: Alignment.topCenter,
                          fit: BoxFit.scaleDown,
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            width: 320,
                            height: 150,
                            margin: const EdgeInsets.only(right: 8),
                            child: MapCardSmall(key: Key("$index"), listingSelected[index]),
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

  bool getIsLoad() {
    // isLoading = context.select((MapListProvider m) => m.loadMap);
    isLoading = Provider.of<MapListProvider>(context).loadMap;

    return isLoading;
  }
}
