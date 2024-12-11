import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/shared/components/constants.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  fontFamily: 'Jannah',
  scaffoldBackgroundColor: HexColor('333739'),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.deepOrange,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    color: HexColor('333739'),
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor),
  unselectedWidgetColor: Colors.grey,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
        fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
  ),
);
ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  fontFamily: 'Jannah',
  textTheme: TextTheme(
    bodyLarge: TextStyle(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.deepOrange,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed, selectedItemColor: defaultColor),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
);
