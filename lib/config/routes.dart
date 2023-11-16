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
  'card_details_full_sold_screen': ( _ ) => const CardDetailsFullSoldScreen(),
  'card_images_screen': ( _ ) => const CardImagesScreen(),
  'game_welcome_screen': ( _ ) => const GameWelcomeScreen(),
  'game_screen': ( _ ) => const GameScreen(),
  FavoritesScreen.pathScreen: ( _ ) => const FavoritesScreen(),
  LoginScreen.pathScreen: ( _ ) => const LoginScreen(),
  RegisterScreen.pathScreen: ( _ ) => const RegisterScreen(),
  RegisterPinScreen.pathScreen: ( _ ) => const RegisterPinScreen(),
  RegisterTermsUseScreen.pathScreen: ( _ ) => const RegisterTermsUseScreen(),
  RegisterFinishScreen.pathScreen: ( _ ) => const RegisterFinishScreen(),
  AccountScreen.pathScreen: ( _ ) => const AccountScreen(),
  AccountChangePasswordScreen.pathScreen: ( _ ) => const AccountChangePasswordScreen(),
  AccountDeleteScreen.pathScreen: ( _ ) => const AccountDeleteScreen(),
  ContactAgentScreen.pathScreen: ( _ ) => const ContactAgentScreen(),
  ForgotPasswordScreen.pathScreen: ( _ ) => const ForgotPasswordScreen()
};
