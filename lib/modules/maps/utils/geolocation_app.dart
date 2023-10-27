import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GeolocationApp {
  late LocationSettings locationSettings;

  GeolocationApp();

  Future<LatLng> getPosition() async {
    var coordinatesDefault = const LatLng(43.656008, -79.382189);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.value(coordinatesDefault);
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        return Future.value(coordinatesDefault);
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.value(coordinatesDefault);
      }

      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return Future.value(LatLng(position.latitude, position.longitude));
    } catch (e) {
      return Future.error(coordinatesDefault);
    }
  }

  Future<void> requestLocalization() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Future.error(const LatLng(0, 0));
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return Future.error(const LatLng(0, 0));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(const LatLng(0, 0));
      }
    } catch (e) {
      Future.error(e.toString());
    }
  }

  static Future<void> openSettingsGeolocation() async {
    await Geolocator.openAppSettings();
  }
}
