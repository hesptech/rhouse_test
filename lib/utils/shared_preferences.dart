import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  
  static late SharedPreferences _prefs;

  static bool _isLoggedIn = false;
  static List<String> _filtersClassButtons = [];
  static List<String> _userFilters = [];
  static List<String> _userFiltersIsLoggedIn = [];
  static List<String> _userFiltersCity = [];
  static List<String> _userFiltersCityIsLoggedIn = [];
  static List<String> _userFiltersCityGtaNorth = [];
  static List<String> _userFiltersCityGtaNorthLoggedIn = [];

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // is LoggedIn
  static bool get isLoggedIn {
    return _prefs.getBool('isLoggedIn') ?? _isLoggedIn;
  }

  static set isLoggedIn( bool value ) {
    _isLoggedIn = value;
    _prefs.setBool( 'isLoggedIn', value );
  }

  // Type
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

  // CITY
  // GtaCentral
  static List<String> get userFiltersCity {
    return _prefs.getStringList( 'userFiltersCity') ?? _userFiltersCity;
  }

  static set userFiltersCity( List<String> value ) {
    _userFiltersCity = value;
    _prefs.setStringList( 'userFiltersCity', value );
  }

  static List<String> get userFiltersCityIsLoggedIn {
    return _prefs.getStringList( 'userFiltersCityIsLoggedIn') ?? _userFiltersCityIsLoggedIn;
  }

  static set userFiltersCityIsLoggedIn( List<String> value ) {
    _userFiltersCityIsLoggedIn = value;
    _prefs.setStringList( 'userFiltersCityIsLoggedIn', value );
  }

  // GtaNorth
  static List<String> get userFiltersCityGtaNorth {
    return _prefs.getStringList( 'userFiltersCityGtaNorth') ?? _userFiltersCityGtaNorth;
  }

  static set userFiltersCityGtaNorth( List<String> value ) {
    _userFiltersCityGtaNorth = value;
    _prefs.setStringList( 'userFiltersCityGtaNorth', value );
  }

  static List<String> get userFiltersCityGtaNorthLoggedIn {
    return _prefs.getStringList( 'userFiltersCityGtaNorthLoggedIn') ?? _userFiltersCityGtaNorthLoggedIn;
  }

  static set userFiltersCityGtaNorthLoggedIn( List<String> value ) {
    _userFiltersCityGtaNorthLoggedIn = value;
    _prefs.setStringList( 'userFiltersCityGtaNorthLoggedIn', value );
  } 

  /// FILTERS
  static List<String> get filtersClassButtons {
    return _prefs.getStringList('filtersClassButtons') ?? _filtersClassButtons;
  }

  static set filtersClassButtons( List<String> value ) {
    _filtersClassButtons = value;
    _prefs.setStringList('filtersClassButtons', value);
  } 
}
