import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class FiltersClassButtons extends StatefulWidget {
  const FiltersClassButtons({Key? key}) : super(key: key);

  @override
  State<FiltersClassButtons> createState() => _FiltersClassButtonsState();
}

class _FiltersClassButtonsState extends State<FiltersClassButtons> {

  late List<String> _filtersClassButtons;
  late double _locationLat;
  late double _locationLng;


  String location = 'Null';

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) { 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    return await Geolocator.getCurrentPosition();
  }

  getUserLocation() async {
    Position position = await _determinePosition();
    Preferences.locationLat = position.latitude;
    Preferences.locationLng = position.longitude;
    location = 'Lat: ${position.latitude}, Alt: ${position.longitude}';
    _locationLat = position.latitude;
    _locationLng = position.longitude;
    //print(location);
  }  



  @override
  void initState() {
    super.initState();
    _filtersClassButtons = Preferences.filtersClassButtons;
    _locationLat = Preferences.locationLat;
    _locationLng = Preferences.locationLng;
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: Container(
            width: 120.0,
            alignment: Alignment.center,
            child: Text('HOUSES', style: TextStyle( color: _filtersClassButtons.contains('houses') ? Colors.white : kPrimaryColor),),
          ),
          backgroundColor: kBackgroundColor,
          selectedColor: _filtersClassButtons.contains('houses') ? kPrimaryColor : kBackgroundColor,
          selected: _filtersClassButtons.contains('houses'),
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(4))),
          side: const BorderSide( color: kPrimaryColor ),
          onSelected: ( bool selected ) {
            setState(() {
              selected ? _filtersClassButtons.add('houses') : _filtersClassButtons.removeWhere((String name) => name == 'houses') ;
              Preferences.filtersClassButtons = _filtersClassButtons;
            });            
          },
        ),
        const SizedBox( width: 8.0,),
        ChoiceChip(
          label: Container(
            width: 120.0,
            alignment: Alignment.center,
            child: Text('CONDOS', style: TextStyle( color: _filtersClassButtons.contains('condos') ? Colors.white : kPrimaryColor),),
          ),
          backgroundColor: kBackgroundColor,
          selectedColor: _filtersClassButtons.contains('condos') ? kPrimaryColor : kBackgroundColor,
          selected: _filtersClassButtons.contains('condos'),
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(4))),
          side: const BorderSide( color: kPrimaryColor ),
          onSelected: ( bool selected ) {
            setState(() {
              selected ? _filtersClassButtons.add('condos') : _filtersClassButtons.removeWhere((String name) => name == 'condos') ;
              Preferences.filtersClassButtons = _filtersClassButtons;
            });            
          },
        ),
        //Text('A: ${Preferences.filtersClassButtons}'),
        //Text('B: ${_filtersClassButtons.join(', ')}'),      
      ],
    );
  }
}