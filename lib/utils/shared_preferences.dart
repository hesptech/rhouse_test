import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  
  static late SharedPreferences _prefs;

  static bool _isLoggedIn = false;
  static List<String> _userFilters = [];
  static List<String> _userFiltersIsLoggedIn = [];

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isLoggedIn {
    return _prefs.getBool('isLoggedIn') ?? _isLoggedIn;
  }

  static set isLoggedIn( bool value ) {
    _isLoggedIn = value;
    _prefs.setBool( 'isLoggedIn', value );
  }

  static List<String> get userFilters {
    return _prefs.getStringList( 'userFilters') ?? _userFilters;
  }

  static set userFilters( List<String> value ) {
    _userFilters = value;
    _prefs.setStringList( 'userFilters', value );
  }

  static List<String> get userFiltersIsLoggedIn {
    return _prefs.getStringList( 'userFiltersIsLoggedIn') ?? _userFiltersIsLoggedIn;
  }

  static set userFiltersIsLoggedIn( List<String> value ) {
    _userFiltersIsLoggedIn = value;
    _prefs.setStringList( 'userFiltersIsLoggedIn', value );
  }

}