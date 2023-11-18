
import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/navigator_config.dart';
import 'package:flutter_black_white/utils/enums_app.dart';
export 'package:flutter_black_white/utils/enums_app.dart';

class SnackBarAppWidget {
  static void show({String message = "", StatusColor statusColor = StatusColor.dark}) {
    var colorBackground = mapColors[statusColor.name];

    try {
      ScaffoldMessenger.of(NavigatorConfig.context).hideCurrentSnackBar();

      ScaffoldMessenger.of(NavigatorConfig.context).showSnackBar(SnackBar(
        content: Text(
          message,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
        ),
        backgroundColor: colorBackground,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(19),
        dismissDirection: DismissDirection.startToEnd,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
