import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/http_proccess_response.dart';
import 'package:flutter_black_white/config/navigator_config.dart';
import 'package:flutter_black_white/models/auth_info_app.dart';
import 'package:flutter_black_white/models/authentication_request_model.dart';
import 'package:flutter_black_white/models/authentication_response_model.dart';
import 'package:flutter_black_white/screens/account/account_screen.dart';
import 'package:flutter_black_white/utils/authentication_singleton.dart';
import 'package:flutter_black_white/utils/format_date_util.dart';
import 'package:flutter_black_white/utils/store_app_shared.dart';
import 'package:flutter_black_white/widgets/loadable_widget.dart';
import 'package:flutter_black_white/widgets/snack_bar_app_widget.dart';

class AuthenticationProvider {
  void login(String email, String password) async {
    try {
      var request = AuthenticationRequestModel(email: email, password: password);

      loadingDialogShow();
      var result = await HttpProcessResponse.post<AuthenticationResponseModel>(HttpProcessResponse.login, body: request.toJson());
      NavigatorConfig.pop();
      
      if (!result.error.isNotEmpty) { //TODO: quita el operador de negación
        SnackBarAppWidget.show(message: result.error, statusColor: StatusColor.danger);
        return;
      }

      var authResponseData = result.data ?? AuthenticationResponseModel(
        email: "emai@test.com",
        expiresIn: DateTime.now().toUtc().add(Duration(days: 30)),
        name: "John",
        lastName: "Smith",
        registrationDate: DateTime.now(),
        token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOm51bGx9.D_OA8tFtGiiNoULLnYCz82dPGo5hFleWdiPEdhXFvGw",
        tokenType: "jwt",
        userId: 899
      ); //TODO: quitar estos valores

      await StoreAppShared.write(StoreAppSharedKeys.expiresIn, authResponseData.expiresIn!.toIso8601String());
      await StoreAppShared.write(StoreAppSharedKeys.token, authResponseData.token);
      await StoreAppShared.write(StoreAppSharedKeys.userId, authResponseData.userId.toString());

      await StoreAppShared.write(StoreAppSharedKeys.token, authResponseData.token);

      AuthSingleton authSingleton = AuthSingleton();

      authSingleton.authInfo = AuthInfoApp(
          email: authResponseData.email,
          name: authResponseData.name,
          lastName: authResponseData.lastName,
          userId: authResponseData.userId,
          expiresIn: authResponseData.expiresIn,
          registrationDate: FormatDateUtil.convertDatetimeToStrin(authResponseData.registrationDate!));
      await StoreAppShared.write(StoreAppSharedKeys.dataInfo, authInfoAppToJson(authSingleton.authInfo));

      NavigatorConfig.pushAndRemoveUntil(AccountScreen.pathScreen);
    } catch (_) {
      debugPrint("Error --> ${_.toString()}");
      SnackBarAppWidget.show(message: "Something went wrong", statusColor: StatusColor.dark);
    }
  }
}
