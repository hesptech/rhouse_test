import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/application_state.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/screens/screens.dart';
import 'package:flutter_black_white/utils/constants.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  runApp( const AppState() );
}


class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApplicationState(),
          builder: (context, _) => const App(),
        ),
      ],
      child: const App(),
    );
  }
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RHOUZE',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: kPrimaryColor,
        ),
        scaffoldBackgroundColor: kBackgroundColor,
        /* buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: kBackgroundColor,
            ), */
        //primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),


      initialRoute: '/',
      routes: {
        '/': ( _ ) => const HomeScreen(),
        'login_screen': ( _ ) => const LoginScreen(),
        'filters_screen': ( _ ) => const FiltersScreen(),
      },
    );
  }
}
