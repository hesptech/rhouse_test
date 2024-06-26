import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/config/config.dart';
import 'package:flutter_black_white/providers/providers.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/config/navigator_config.dart';

void main() async {
  await dotenv.load();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Preferences.init();

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => FilterProvider() ),
        ChangeNotifierProvider( create: (_) => RepliersProvider(Preferences.filtersStatusProperties), lazy: false ),
        ChangeNotifierProvider( create: (_) => RepliersFilters('toronto ALL') ),
        ChangeNotifierProvider( create: (_) => RepliersListingMls() ),
        ChangeNotifierProvider( create: (_) => RepliersSearch(), ),
        ChangeNotifierProvider( create: (_) => MapListProvider() ),
        ChangeNotifierProvider( create: (_) => RepliersGame(), ),
        ChangeNotifierProvider( create: (_) => RepliersFavorites(), ),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RHOUZE',
        theme: theme,
        initialRoute: '/',
        navigatorKey: NavigatorConfig.globalkey,
        routes: customRoutes,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
