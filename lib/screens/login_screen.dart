import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/application_state.dart';
import 'package:flutter_black_white/utils/authentication.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text('Log in or sign up'),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 8),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Authentication(
              email: appState.email,
              loginState: appState.loginState,
              startLoginFlow: appState.startLoginFlow,
              verifyEmail: appState.verifyEmail,
              signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
              cancelRegistration: appState.cancelRegistration,
              registerAccount: appState.registerAccount,
              signOut: appState.signOut,
            ),
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loginState == ApplicationLoginState.loggedIn) ...[
                  //const Text('User name'),
                  //Text(FirebaseAuth.instance.currentUser?.displayName ?? 'no name'),
                  //Text('Log2: ${Preferences.isLoggedIn}'),
                ],
              ],
            ),
          ),
        ],
      ),
    );     
  }
}
