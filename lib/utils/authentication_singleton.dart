import 'package:flutter_black_white/models/auth_info_app.dart';
import 'package:flutter_black_white/utils/enums_app.dart';

class AuthSingleton {
  static AuthSingleton? _instance;
  AuthInfoApp authInfo = AuthInfoApp();

  AuthSingleton._internal();

  factory AuthSingleton() {
    _instance ??= AuthSingleton._internal();
    return _instance!;
  }

  AuthStatus get authStatus {
    try {
      if (authInfo.expiresIn!.isBefore(DateTime.now().toUtc())) {
        return AuthStatus.notAuthenticated;
      }
      
      return AuthStatus.authenticated;
    } catch (_) {
      return AuthStatus.notAuthenticated;
    }
  }
}
