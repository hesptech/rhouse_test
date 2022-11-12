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
  static List<String> _filterPropertyIcons = [];
  static List<String> _filterPropertyType = [];

  static List<String> _userFilters = [];
  static List<String> _userFiltersCity = [];

  static List<String> _filtersLocationTopbts = [];
  static List<String> _filtersTrCentral = [];
  static List<String> _filtersTrEast = [];
  static List<String> _filtersTrWest = [];
  static List<String> _filtersGtaWest = [];
  static List<String> _filtersGtaNorth = [];
  static List<String> _filtersGtaEast = [];
  static List<String> _filtersOther = [];


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


  /// FILTERS Class Buttons
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


  /// FILTER Property Icons
  static List<String> get filterPropertyIcons {
    return _prefs.getStringList('filterPropertyIcons') ?? _filterPropertyIcons;
  }

  static set filterPropertyIcons( List<String> value ) {
    _filterPropertyIcons = value;
    _prefs.setStringList( 'filterPropertyIcons', value );
  }


  /// FILTER Property Type
  static List<String> get filterPropertyType {
    return _prefs.getStringList('filterPropertyType') ?? _filterPropertyType;
  }

  static set filterPropertyType( List<String> value ) {
    _filterPropertyType = value;
    _prefs.setStringList( 'filterPropertyType', value );
  }


  // CITY
  static List<String> get userFiltersCity {
    return _prefs.getStringList( 'userFiltersCity') ?? _userFiltersCity;
  }

  static set userFiltersCity( List<String> value ) {
    _userFiltersCity = value;
    _prefs.setStringList( 'userFiltersCity', value );
  }


  // FILTERS Location Topbts
  static List<String> get filtersLocationTopbts {
    return _prefs.getStringList('filtersLocationTopbts') ?? _filtersLocationTopbts;
  }

  static set filtersLocationTopbts( List<String> value ) {
    _filtersLocationTopbts = value;
    _prefs.setStringList( 'filtersLocationTopbts', value );
  }


  // FILTERS Tr Central
  static List<String> get filtersTrCentral {
    return _prefs.getStringList('filtersTrCentral') ?? _filtersTrCentral;
  }

  static set filtersTrCentral( List<String> value ) {
    _filtersTrCentral = value;
    _prefs.setStringList( 'filtersTrCentral', value );
  }

  // FILTERS Tr East
  static List<String> get filtersTrEast {
    return _prefs.getStringList('filtersTrEast') ?? _filtersTrEast;
  }

  static set filtersTrEast( List<String> value ) {
    _filtersTrEast = value;
    _prefs.setStringList( 'filtersTrEast', value );
  }

  // FILTERS Tr West
  static List<String> get filtersTrWest {
    return _prefs.getStringList('filtersTrWest') ?? _filtersTrWest;
  }

  static set filtersTrWest( List<String> value ) {
    _filtersTrWest = value;
    _prefs.setStringList( 'filtersTrWest', value );
  }

  // FILTERS Gta West
  static List<String> get filtersGtaWest {
    return _prefs.getStringList('filtersGtaWest') ?? _filtersGtaWest;
  }

  static set filtersGtaWest( List<String> value ) {
    _filtersGtaWest = value;
    _prefs.setStringList( 'filtersGtaWest', value );
  }

  // FILTERS Gta North
  static List<String> get filtersGtaNorth {
    return _prefs.getStringList('filtersGtaNorth') ?? _filtersGtaNorth;
  }

  static set filtersGtaNorth( List<String> value ) {
    _filtersGtaNorth = value;
    _prefs.setStringList( 'filtersGtaNorth', value );
  }

  // FILTERS Gta East
  static List<String> get filtersGtaEast {
    return _prefs.getStringList('filtersGtaEast') ?? _filtersGtaEast;
  }

  static set filtersGtaEast( List<String> value ) {
    _filtersGtaEast = value;
    _prefs.setStringList( 'filtersGtaEast', value );
  }

  // FILTERS Other
  static List<String> get filtersOther {
    return _prefs.getStringList('filtersOther') ?? _filtersOther;
  }

  static set filtersOther( List<String> value ) {
    _filtersOther = value;
    _prefs.setStringList( 'filtersOther', value );
  }
}
