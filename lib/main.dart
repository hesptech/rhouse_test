import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/application_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/screens/screens.dart';

void main() {
  // Modify from here
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => const App(),
    ),
  );
  // to here.
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Meetup',
      theme: ThemeData(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: Colors.deepPurple,
            ),
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.robotoTextTheme(
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
      },
    );
  }
}
