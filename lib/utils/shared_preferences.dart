import 'package:shared_preferences/shared_preferences.dart';
//import 'package:geolocator/geolocator.dart';

class Preferences {
  
  static late SharedPreferences _prefs;

  static bool _isLoggedIn = false;
  static double _locationLat = 43.651070;
  static double _locationLng = -79.347015;
  static List<String> _filtersClassButtons = [];
  static double _filterPriceRangeStart = 500000;
  static double _filterPriceRangeEnd = 2000000; 
  static List<String> _filterClassIcons = [];
  static List<String> _userFilters = [];
  static List<String> _userFiltersCity = [];


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

  // GEO-LOCATION: latitude - longitude
  static double get locationLat {
    return _prefs.getDouble( 'locationLat') ?? _locationLat;
  }

  static set locationLat( double value ) {
    _locationLat = value;
    _prefs.setDouble( 'locationLat', value );
  }

  static double get locationLng {
    return _prefs.getDouble( 'locationLng') ?? _locationLng;
  }

  static set locationLng( double value ) {
    _locationLng = value;
    _prefs.setDouble('locationLng', value );
  }



  // FILTERS: price range
  static double get filterPriceRangeStart {
    return _prefs.getDouble( 'filterPriceRangeStart' ) ?? _filterPriceRangeStart;
  }
  static set filterPriceRangeStart( double value ) {
    _filterPriceRangeStart = value;
    _prefs.setDouble( 'filterPriceRangeStart', value );
  }


  static double get filterPriceRangeEnd {
    return _prefs.getDouble( 'filterPriceRangeEnd' ) ?? _filterPriceRangeEnd;
  }

  static set filterPriceRangeEnd( double value ) {
    _filterPriceRangeEnd = value;
    _prefs.setDouble( 'filterPriceRangeEnd', value );
  }


  // Type
  static List<String> get userFilters {
    return _prefs.getStringList( 'userFilters') ?? _userFilters;
  }

  static set userFilters( List<String> value ) {
    _userFilters = value;
    _prefs.setStringList( 'userFilters', value );
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


  /// FILTERS
  static List<String> get filtersClassButtons {
    return _prefs.getStringList('filtersClassButtons') ?? _filtersClassButtons;
  }

  static set filtersClassButtons( List<String> value ) {
    _filtersClassButtons = value;
    _prefs.setStringList('filtersClassButtons', value);
  } 


  /// FILTER Class Icons
  static List<String> get filterClassIcons {
    return _prefs.getStringList('filterClassIcons') ?? _filterClassIcons;
  }

  static set filterClassIcons( List<String> value ) {
    _filterClassIcons = value;
    _prefs.setStringList( 'filterClassIcons', value );
  }
}
