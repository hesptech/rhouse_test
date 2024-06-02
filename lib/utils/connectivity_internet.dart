import 'package:connectivity_plus/connectivity_plus.dart';
export 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityInternet {
  static late ConnectivityResult _result;

  static Future<bool> hasConnection() async {
    _result = await Connectivity().checkConnectivity();
    if (_result == ConnectivityResult.mobile) return true;
    if (_result == ConnectivityResult.wifi) return true;
    if (_result == ConnectivityResult.ethernet) return true;
    if (_result == ConnectivityResult.other) return true;
    if (_result == ConnectivityResult.vpn) return true;
    return false;
  }
}