import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GeolocationApp {
  late LocationSettings locationSettings;

  GeolocationApp();

  Future<LatLng> getPosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error(LatLng(0, 0));
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error(LatLng(0, 0));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(LatLng(0, 0));
      }

      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return Future.value(LatLng(position.latitude, position.longitude));
    } catch (e) {
      return Future.error(LatLng(0, 0));
    }
  }

  static Future<void> openSettingsGeolocation() async {
    await Geolocator.openAppSettings();
  }
}
