import 'package:flutter_black_white/config/http_proccess_response.dart';
import 'package:flutter_black_white/config/navigator_config.dart';
import 'package:flutter_black_white/models/password_request_model.dart';
import 'package:flutter_black_white/utils/authentication_singleton.dart';
import 'package:flutter_black_white/widgets/loadable_widget.dart';
import 'package:flutter_black_white/widgets/snack_bar_app_widget.dart';

class ChangePasswordProvider {
  void changePassword(String passwordNew) async {
    try {
      AuthSingleton authSingleton = AuthSingleton();

      var request = PasswordRequestModel(email: authSingleton.authInfo.email, passwordNew: passwordNew);
      loadingDialogShow();
      var result = await HttpProcessResponse.patch<bool>(HttpProcessResponse.updatePassword, body: request.toJson());
      NavigatorConfig.pop();

      if (!result.error.isNotEmpty) {
        SnackBarAppWidget.show(message: result.error, statusColor: StatusColor.danger);
        return;
      }

      SnackBarAppWidget.show(message: result.message, statusColor: StatusColor.dark);
      NavigatorConfig.pushAndRemoveUntil("/");
    } catch (_) {
      SnackBarAppWidget.show(message: "Something went wrong", statusColor: StatusColor.dark);
    }
  }
}
