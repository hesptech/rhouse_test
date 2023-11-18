import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/navigator_config.dart';

class MessagesDialogsWidget {
  static dialogFixed({required Widget child, required void Function() ok, void Function()? cancel}) {
    showDialog(
      barrierDismissible: false,
      context: NavigatorConfig.context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              elevation: 0,
              content: child,
              actionsPadding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 8),
              actions: [
                cancel != null
                    ? TextButton(
                        onPressed: () => cancel(),
                        child: const Text('Cancel'),
                      )
                    : Container(),
                TextButton(
                  onPressed: () => ok(),
                  child: const Text('OK'),
                ),
              ],
            ));
      },
    );
  }

  static Future<void> dialogInformation({required Widget title, required Widget content, required void Function() ok, void Function()? cancel}) async {
    await showDialog(
      barrierDismissible: true,
      context: NavigatorConfig.context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          content: content,
          title: title,
          actionsPadding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 8),
          actions: [
            TextButton(
              onPressed: cancel != null ? () => cancel() : () => _cancel(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => ok(),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  static void _cancel() {
    NavigatorConfig.pop();
  }
}
