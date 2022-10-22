import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:show_pictures/shared/style/color.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  primarySwatch: Colors.indigo,
  appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryColor),
      actionsIconTheme: IconThemeData(color: primaryColor),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 20,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Jannah',
);
