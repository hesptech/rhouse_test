import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreAppShared {
  static late FlutterSecureStorage _prefs;

  static void _getInstance() => _prefs = const FlutterSecureStorage();

  static Future<String> read(String key) async {
    _getInstance();
    var readValue = await _prefs.read(key: key) ?? "";
    return readValue;
  }

  static Future<void> write(String key, dynamic value) async {
    _getInstance();
    await _prefs.write(key: key, value: value);
  }

  static void remove(String key) async {
    _getInstance();
    await _prefs.delete(key: key);
  }

  static Future<void> deleteAll() async {
    _getInstance();
    await _prefs.deleteAll();
  }
}

class StoreAppSharedKeys {
  static const String token = "tokenApp";
  static const String userId = "userId";
  static const String expiresIn = "expiresIn";
  static const String dataInfo = "dataInfo";
}
