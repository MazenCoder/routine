import 'package:flutter/material.dart';

class AppTheme {
  // Private Constructor
  AppTheme._();

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFBDBDBD),
    appBarTheme: AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      // Time and "Routine List"
      headline1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 30,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 56,
      ),
      // UTC
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 13.0,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      // clock_view_day
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ),
    buttonColor: Color(0xFF616E7C),
    canvasColor: Colors.white,
    cardColor: Color(0xFF857F72),
    accentColor: Color(0xFF27241D),
    bottomAppBarColor: Colors.white,
  );

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xFF212121),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 56,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      buttonColor: Color(0xFF27241D),
      canvasColor: Colors.white,
      cardColor: Color(0xFF675e35),
      accentColor: Colors.teal[800],
      bottomAppBarColor: Colors.grey[850]);
}
