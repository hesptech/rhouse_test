import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_black_white/utils/constants.dart';

final ThemeData theme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: kPrimaryColor,
  ),
  scaffoldBackgroundColor: kBackgroundColor,
  fontFamily: GoogleFonts.openSans().fontFamily,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
