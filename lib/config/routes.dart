import 'package:flutter/material.dart';
import 'package:flutter_black_white/screens/map_property_screen.dart';
import 'package:flutter_black_white/screens/screens.dart';

var customRoutes = <String, WidgetBuilder>{
  '/': ( _ ) => const HomeScreen(),
  MapScreen.pathScreen: ( _ ) => const MapScreen(),
  MapPropertyScreen.pathScreen: ( _ ) => const MapPropertyScreen(),
  'filters_screen': ( _ ) => const FiltersScreen(),
  'filters_results_screen': ( _ ) => const FiltersResultsScreen(),
  'card_details_full_screen': ( _ ) => const CardDetailsFullScreen(),
  'card_images_screen': ( _ ) => const CardImagesScreen(),
  LoginScreen.pathScreen: ( _ ) => const LoginScreen(),
  RegisterScreen.pathScreen: ( _ ) => const RegisterScreen(),
  RegisterPinScreen.pathScreen: ( _ ) => const RegisterPinScreen(),
  RegisterTermsUseScreen.pathScreen: ( _ ) => const RegisterTermsUseScreen(),
  RegisterFinishScreen.pathScreen: ( _ ) => const RegisterFinishScreen()
};
