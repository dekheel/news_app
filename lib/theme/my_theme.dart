import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = const Color(0xff39A552);
  static Color whiteColor = const Color(0xffffffff);
  static Color blackColor = const Color(0xff303030);

  static ThemeData lightTeme = ThemeData(
      appBarTheme: AppBarTheme(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(40) , bottomLeft: Radius.circular(40))
        ),
        color: primaryColor,
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              color: whiteColor, fontWeight: FontWeight.bold, fontSize: 22)));
}
