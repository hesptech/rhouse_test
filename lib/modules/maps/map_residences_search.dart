import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_black_white/models/response_listings.dart';
import 'package:flutter_black_white/modules/maps/map_card_small.dart';
import 'package:flutter_black_white/providers/maplist_provider.dart';
import 'package:flutter_black_white/utils/geolocation_app.dart';
import 'package:flutter_black_white/widgets/loadable_widget.dart';
import 'package:flutter_black_white/widgets/maptiler_widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapResidencesSearch extends StatefulWidget {
  final Style style;
  final TileOffset tileOffset;
  final bool isFilter;

  const MapResidencesSearch({super.key, required this.style, this.tileOffset = TileOffset.DEFAULT, this.isFilter = false});

  @override
  State<MapResidencesSearch> createState() => _MapResidencesSearchState();
}

class _MapResidencesSearchState extends State<MapResidencesSearch> {
  late List<Listing> listingsData;
  late List<Marker> markersList;
  late MapListProvider mapListProvider;

  @override
  void initState() {
    listingsData = [];
    markersList = [];
    super.initState();
    MapListProvider.intiConfig(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<MapListProvider>(context, listen: false).listingSelected = [];
        listingsData = [];
        return true;
      },
      child: FutureBuilder<LatLng>(
          future: GeolocationApp().getPosition(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadWidget();
            }

            var value = snapshot.data ?? LatLng(0, 0);

            if (listingsData.isEmpty) {
              return _mapWidget(value, context);
            }

            return _mapTilerList(value, listingsData, context);
          }),
    );
  }

  Widget _mapWidget(LatLng coordinates, BuildContext context) {
    return FutureBuilder<List<Listing>>(
        future: MapListProvider().getLocationsResidences(widget.isFilter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadWidget();
          }

          var data = snapshot.data ?? [];

          if (listingsData.isEmpty) {
            listingsData = data;
          }

          return _mapTilerList(coordinates, data, context);
        });
  }

  Widget _mapTilerList(LatLng coordinates, List<Listing> data, BuildContext context) {
    if (markersList.isEmpty) {
      markersList = Provider.of<MapListProvider>(context).selectedCluster;      
    }
    return MapTilerWidget(
        center: coordinates,
        listCoordinates: data,
        selectedCluster: markersList,
        cards: _scrollListing(context),
        onClusterTap: (markerClusred) {
          onTapMarkers(markerClusred.mapMarkers, data, context);
        },
        onTapMarker: (mapMarkers) {
          onTapMarkers(mapMarkers, data, context);
        },
        changeZoom: (mapEvent) {
          Provider.of<MapListProvider>(context, listen: false).selectedCluster = [];          
          markersList = [];
        },
        zoom: 5,
        isMultiple: true,
        layerFactory: (context, layerMode) => VectorTileLayer(
            tileProviders: widget.style.providers, theme: widget.style.theme, layerMode: layerMode, tileOffset: widget.tileOffset));
  }

  void onTapMarkers(List<Marker>  mapMarkers, List<Listing> listCoordinates, BuildContext context) async {
    Provider.of<MapListProvider>(context, listen: false).getFileterListings(mapMarkers, listCoordinates);
    Provider.of<MapListProvider>(context, listen: false).selectedCluster = mapMarkers;
    markersList = [];
  }

  Widget _scrollListing(BuildContext context) {
    var providerMapList = Provider.of<MapListProvider>(context);

    return Visibility(
      visible: markersList.isNotEmpty,
      child: Container(
        width: double.infinity,
        height: 230,
        color: const Color(0XFF09B68D),
        child: Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 15, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${providerMapList.listingSelected.length} listings in total",
                    style: const TextStyle(color: Colors.white, fontSize: 14.8),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      Provider.of<MapListProvider>(context, listen: false).selectedCluster = [];
                      markersList = [];
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 155,
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemCount: providerMapList.listingSelected.length,
                    itemBuilder: (_, index) {
                      return Container(
                        padding: const EdgeInsets.all(0),
                        width: 320,
                        height: 137,
                        margin: const EdgeInsets.only(right: 10),
                        child: MapCardSmall(providerMapList.listingSelected[index]),
                      );
                    }),
              ),
              Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }
}
