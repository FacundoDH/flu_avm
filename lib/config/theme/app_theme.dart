import 'package:flutter/material.dart';

class AppTheme {
  
  final Color chooseColor;

  AppTheme([
    this.chooseColor = const Color(0xFF1E1C36)
  ]);

  ThemeData getTheme() => ThemeData( //con la flecha hacemos que la función devuelva una única cosa
    colorSchemeSeed: chooseColor,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
    )
  );
}