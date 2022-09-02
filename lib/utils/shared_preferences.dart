import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  
  static late SharedPreferences _prefs;

  static String _name = '';
  static bool _isLoggedIn = false;
  static int _gender = 1;
  static List<String> _userFilters = [];

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static set name( String name ) {
    _name = name;
    _prefs.setString( 'name', name );
  }

  static bool get isLoggedIn {
    return _prefs.getBool('isLoggedIn') ?? _isLoggedIn;
  }

  static set isLoggedIn( bool value ) {
    _isLoggedIn = value;
    _prefs.setBool( 'isLoggedIn', value );
  }

  static int get gender {
    return _prefs.getInt('gender') ?? _gender;
  }

  static set gender( int value ) {
    _gender = value;
    _prefs.setInt( 'gender', value );
  }

  static List<String> get userFilters {
    return _prefs.getStringList( 'userFilters') ?? _userFilters;
  }

  static set userFilters( List<String> value ) {
    _userFilters = value;
    _prefs.setStringList( 'userFilters', value );
  }

}