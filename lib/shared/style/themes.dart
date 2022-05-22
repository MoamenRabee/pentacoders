import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData myTheme(){
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Janna Regular",
    primarySwatch: Colors.blue,
    applyElevationOverlayColor: true,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      color: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Janna Regular",
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      actionsIconTheme: IconThemeData(
          color: Colors.black
      ),
      elevation: 0.0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 0.0,
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: TextStyle(
          color: Colors.black
      ),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,

    ),
  );
}