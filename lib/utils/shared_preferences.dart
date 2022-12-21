import 'package:shared_preferences/shared_preferences.dart';
//import 'package:geolocator/geolocator.dart';

class Preferences {
  
  static late SharedPreferences _prefs;

  static bool _isLoggedIn = false;
  static double _locationLat = 43.651070;
  static double _locationLng = -79.347015;
  static List<String> _filtersClassButtons = [];

  static double _filterPriceRangeStart = 400000;
  static double _filterPriceRangeEnd = 2000000; 
  static String _filtersClassIconsBt = 'residential';
  static List<String> _filterPropertyIcons = [];
  static List<String> _filterPropertyType = [];
  static List<String> _filtersLocationTopbts = [];
  static List<String> _filtersTrCentral = [];
  static List<String> _filtersTrEast = [];
  static List<String> _filtersTrWest = [];
  static List<String> _filtersGtaWest = [];
  static List<String> _filtersGtaNorth = [];
  static List<String> _filtersGtaEast = [];
  static List<String> _filtersOther = [];  
  static int _filtersBedHouse = 0;
  static int _filtersBedCondo = 0;
  static int _filtersBath = 0;
  static double _filterDaysMarketStart = 1.0;
  static double _filterDaysMarketEnd = 30.0;
  static double _filterSizeStart = 10.0;
  static double _filterSizeEnd = 3000.0;
  static double _filterCondoFeeStart = 100.0;
  static double _filterCondoFeeEnd = 1500.0;
  static List<String> _filtersStyleCondo = [];
  static List<String> _filtersStyleHouse = [];
  static List<String> _filtersCondoExtra = [];


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


  // FILTERS Class Buttons
  static List<String> get filtersClassButtons {
    return _prefs.getStringList('filtersClassButtons') ?? _filtersClassButtons;
  }

  static set filtersClassButtons( List<String> value ) {
    _filtersClassButtons = value;
    _prefs.setStringList('filtersClassButtons', value);
  } 




  // FILTERS
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


  /// FILTERS: Filter Class Icons Buttons
  static String get filtersClassIconsBt {
    return _prefs.getString( 'filtersClassIconsBt' ) ?? _filtersClassIconsBt;
  }

  static set filtersClassIconsBt( String value ) {
    _filtersClassIconsBt = value;
    _prefs.setString( 'filtersClassIconsBt', value );
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


  // Bed + Bath
  static int get filtersBedHouse {
    return _prefs.getInt( 'filtersBedHouse' ) ?? _filtersBedHouse;
  }

  static set filtersBedHouse( int value ) {
    _filtersBedHouse = value;
    _prefs.setInt('filtersBedHouse', value);
  }

  static int get filtersBedCondo {
    return _prefs.getInt( 'filtersBedCondo' ) ?? _filtersBedCondo;
  }

  static set filtersBedCondo( int value ) {
    _filtersBedCondo = value;
    _prefs.setInt('filtersBedCondo', value);
  }

  static int get filtersBath {
    return _prefs.getInt( 'filtersBath' ) ?? _filtersBath;
  }

  static set filtersBath( int value ) {
    _filtersBath = value;
    _prefs.setInt( 'filtersBath', value );
  }


  // FILTERS Style House/Condo
  static List<String> get filtersStyleHouse {
    return _prefs.getStringList('filtersStyleHouse') ?? _filtersStyleHouse;
  }

  static set filtersStyleHouse( List<String> value ) {
    _filtersStyleHouse = value;
    _prefs.setStringList( 'filtersStyleHouse', value );
  }

  static List<String> get filtersStyleCondo {
    return _prefs.getStringList('filtersStyleCondo') ?? _filtersStyleCondo;
  }

  static set filtersStyleCondo( List<String> value ) {
    _filtersStyleCondo = value;
    _prefs.setStringList( 'filtersStyleCondo', value );
  }






  // FILTERS Other
  static List<String> get filtersOther {
    return _prefs.getStringList('filtersOther') ?? _filtersOther;
  }

  static set filtersOther( List<String> value ) {
    _filtersOther = value;
    _prefs.setStringList( 'filtersOther', value );
  }


  // FILTERS: Days Market
  static double get filterDaysMarketStart {
    return _prefs.getDouble( 'filterDaysMarketStart' ) ?? _filterDaysMarketStart;
  }
  static set filterDaysMarketStart( double value ) {
    _filterDaysMarketStart = value;
    _prefs.setDouble( 'filterDaysMarketStart', value );
  }

  static double get filterDaysMarketEnd {
    return _prefs.getDouble( 'filterDaysMarketEnd' ) ?? _filterDaysMarketEnd;
  }

  static set filterDaysMarketEnd( double value ) {
    _filterDaysMarketEnd = value;
    _prefs.setDouble( 'filterDaysMarketEnd', value );
  }


  // FILTERS: Size
  static double get filterSizeStart {
    return _prefs.getDouble( 'filterSizeStart' ) ?? _filterSizeStart;
  }
  static set filterSizeStart( double value ) {
    _filterSizeStart = value;
    _prefs.setDouble( 'filterSizeStart', value );
  }

  static double get filterSizeEnd {
    return _prefs.getDouble( 'filterSizeEnd' ) ?? _filterSizeEnd;
  }

  static set filterSizeEnd( double value ) {
    _filterSizeEnd = value;
    _prefs.setDouble( 'filterSizeEnd', value );
  }


  // FILTERS: Condo Fee
  static double get filterCondoFeeStart {
    return _prefs.getDouble( 'filterCondoFeeStart' ) ?? _filterCondoFeeStart;
  }
  static set filterCondoFeeStart( double value ) {
    _filterCondoFeeStart = value;
    _prefs.setDouble( 'filterCondoFeeStart', value );
  }

  static double get filterCondoFeeEnd {
    return _prefs.getDouble( 'filterCondoFeeEnd' ) ?? _filterCondoFeeEnd;
  }

  static set filterCondoFeeEnd( double value ) {
    _filterCondoFeeEnd = value;
    _prefs.setDouble( 'filterCondoFeeEnd', value );
  }


  // FILTERS Condo Extra
  static List<String> get filtersCondoExtra {
    return _prefs.getStringList('filtersCondoExtra') ?? _filtersCondoExtra;
  }

  static set filtersCondoExtra( List<String> value ) {
    _filtersCondoExtra = value;
    _prefs.setStringList( 'filtersCondoExtra', value );
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







  // Type
  static List<String> get userFilters {
    return _prefs.getStringList( 'userFilters') ?? _userFilters;
  }

  static set userFilters( List<String> value ) {
    _userFilters = value;
    _prefs.setStringList( 'userFilters', value );
  }


  // CITY
  static List<String> get userFiltersCity {
    return _prefs.getStringList( 'userFiltersCity') ?? _userFiltersCity;
  }

  static set userFiltersCity( List<String> value ) {
    _userFiltersCity = value;
    _prefs.setStringList( 'userFiltersCity', value );
  }
}
