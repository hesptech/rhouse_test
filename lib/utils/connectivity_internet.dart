import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityInternet {
  
  static Future<bool> hasConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) return true;
    if (result == ConnectivityResult.wifi) return true;
    return false;
  }
}