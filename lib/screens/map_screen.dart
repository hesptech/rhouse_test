import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {

  late GoogleMapController mapController;

  //final LatLng _center = const LatLng(43.651070, -79.347015);
  final LatLng _center = LatLng(Preferences.locationLat,Preferences.locationLng);

  //final Uint8List markerIcon = await getBytesFromAsset('assets/images/evs.png', 100);
  late BitmapDescriptor mapMarker;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), 'assets/map_marker.png');
  }

  /* final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('defaultLocation'),
      position: LatLng(37.4689, -122.1424),
      //icon: BitmapDescriptor.defaultMarker,
      icon: const mapMarker
    )
  }; */

  final Set<Marker> _markers = {};  

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('defaultLocation'),
          position: const LatLng(37.4689, -122.1424),
          icon: mapMarker
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search by Map'),
        backgroundColor: const Color(0xFF2E3191),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: IconButton(
                  onPressed: () {}, 
                  icon: const Icon( Icons.search_outlined, color: Color(0xFF0BB48B), size: 30, ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( top: 0 ),
                child: IconButton(
                  onPressed: () {}, 
                  icon: const Icon( Icons.tune_outlined, color: Color(0xFF0BB48B), size: 30, ),
                ),
              ),               
            ],
          ),
          const SizedBox( width: 10,)         
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
      ),
    );
  }
}