import 'package:flutter_black_white/models/auth_info_app.dart';
import 'package:flutter_black_white/utils/authentication_singleton.dart';
import 'package:flutter_black_white/utils/store_app_shared.dart';

class SessionProvider {
  static Future<void> close() async {
    try {
      StoreAppShared.deleteAll();
      AuthSingleton authSingleton = AuthSingleton();

      authSingleton.authInfo = AuthInfoApp();
    } catch (_) {}
  }

  Future<bool> checkAuthentication() async {
    AuthSingleton authSingleton = AuthSingleton();

    try {
      var expiresIn = await StoreAppShared.read(StoreAppSharedKeys.expiresIn);
      var token = await StoreAppShared.read(StoreAppSharedKeys.token);
      var userId = await StoreAppShared.read(StoreAppSharedKeys.userId);
      var userData = await StoreAppShared.read(StoreAppSharedKeys.dataInfo);

      if (expiresIn.isEmpty || token.isEmpty || userId.isEmpty) {
        authSingleton.authInfo = AuthInfoApp();
        return Future.value(true);
      }

      var expiresInDate = DateTime.parse(expiresIn);

      if (expiresInDate.isBefore(DateTime.now().toUtc())) {
        authSingleton.authInfo = AuthInfoApp();
        return Future.value(true);
      }

      var dataUser = authInfoAppFromJson(userData);
      authSingleton.authInfo = dataUser;
      return Future.value(true);
    } catch (_) {
      authSingleton.authInfo = AuthInfoApp();
      return Future.value(true);
    }
  }
}
