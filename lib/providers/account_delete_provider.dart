import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/http_proccess_response.dart';
import 'package:flutter_black_white/config/navigator_config.dart';
import 'package:flutter_black_white/widgets/loadable_widget.dart';
import 'package:flutter_black_white/widgets/snack_bar_app_widget.dart';

class AccountDeleteProvider {
  

  void deleteAccount() async {
    try {
      loadingDialogShow();
      var result = await HttpProcessResponse.delete<bool>(HttpProcessResponse.deleteAccount);
      NavigatorConfig.pop();
      
      if (result.error.isNotEmpty) {
        SnackBarAppWidget.show(message: result.error, statusColor: StatusColor.danger);
        return;
      }      

      SnackBarAppWidget.show(message: result.message, statusColor: StatusColor.dark);
      NavigatorConfig.pushAndRemoveUntil("/");      
    } catch (_) {
      debugPrint("Error --> ${_.toString()}");
      SnackBarAppWidget.show(message: "Something went wrong", statusColor: StatusColor.dark);      
    }
  }
}