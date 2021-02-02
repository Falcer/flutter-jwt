import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

final lightTheme = AppTheme(
  id: 'default_light_theme',
  description: 'Light Theme',
  data: ThemeData(
    textTheme: AppTheme.light().data.textTheme.apply(
          fontFamily: GoogleFonts.nunito().fontFamily,
          displayColor: Color(0xffB9A0FF),
          bodyColor: Color(0xffB9A0FF),
        ),
    primaryColor: Color(0xff0A043C),
    accentColor: Color(0xff8459FF),
    scaffoldBackgroundColor: const Color(0xff0A043C),
    canvasColor: const Color(0xff0A043C),
    iconTheme: AppTheme.light().data.iconTheme.copyWith(
          color: Color(0xff8459FF),
        ),
  ),
);
