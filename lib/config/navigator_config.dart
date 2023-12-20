import 'package:flutter/material.dart';

class NavigatorConfig {
  static final GlobalKey<NavigatorState> navigatorGlobal = GlobalKey<NavigatorState>();

  static BuildContext get context {
    return navigatorGlobal.currentContext!;
  }

  static GlobalKey<NavigatorState> get globalkey {
    return navigatorGlobal;
  }

  static void pushNamed(String route) {
    navigatorGlobal.currentState!.pushNamed(route);
  }

  static void pushAndRemoveUntil(String routeName) {
    navigatorGlobal.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  static void pop() {
    Navigator.pop(context);
  }
}
