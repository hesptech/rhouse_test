import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/application_state.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/screens/screens.dart';
import 'package:flutter_black_white/utils/constants.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => const App(),
    ),
  );

}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Meetup',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: kPrimaryColor,
        ),
        scaffoldBackgroundColor: kBackgroundColor,
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: kBackgroundColor,
            ),
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
        'login_page_screen': ( _ ) => const LoginPageScreen(),
        'login_account_screen': ( _ ) => const LoginAccountScreen(),
        'filters_screen': ( _ ) => const FiltersScreen(),
      },
    );
  }
}
