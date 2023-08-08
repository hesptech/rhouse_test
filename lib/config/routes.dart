import 'package:flutter/material.dart';
import 'package:flutter_black_white/screens/map_property_screen.dart';
import 'package:flutter_black_white/screens/screens.dart';

var customRoutes = <String, WidgetBuilder>{
  '/': ( _ ) => const HomeScreen(),
  MapScreen.pathScreen: ( _ ) => const MapScreen(),
  MapPropertyScreen.pathScreen: ( _ ) => const MapPropertyScreen(),
  'login_screen': ( _ ) => const LoginScreen(),
  'filters_screen': ( _ ) => const FiltersScreen(),
  'filters_results_screen': ( _ ) => const FiltersResultsScreen(),
  'card_details_full_screen': ( _ ) => const CardDetailsFullScreen(),
  'card_details_full_sold_screen': ( _ ) => const CardDetailsFullSoldScreen(),
  'card_images_screen': ( _ ) => const CardImagesScreen(),
};
