import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  
  final Color chooseColor;

  final bool darkModeState;

  AppTheme({
    this.chooseColor = const Color(0xFF1E1C36),
    this.darkModeState = false
  });

  ThemeData getTheme() => ThemeData( //con la flecha hacemos que la función devuelva una única cosa
    colorSchemeSeed: chooseColor,

    brightness: darkModeState ? Brightness.dark : Brightness.light,

    appBarTheme: const AppBarTheme(
      centerTitle: false,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates()
    )
  );
}