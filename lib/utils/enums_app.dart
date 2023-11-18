import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

enum StatusColor { danger, dark }


final mapColors = {
  StatusColor.danger.name: kWarningColor,
  StatusColor.dark.name: Colors.black
};

enum AuthStatus {authenticated, notAuthenticated}