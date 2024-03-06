// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_final_proj/design/weather_app_colors.dart';

class WeatherAppTheme {

  static ThemeData getWeatherAppTheme() {

    return ThemeData(
      
      // [1] textTheme
      textTheme: TextTheme(
        displayLarge: _titleFont(size: 26.0, color: WAppColor.SECONDARY),
        displayMedium: _titleFont(size: 22.0, color: WAppColor.SECONDARY),
        displaySmall: _titleFont(size: 16.0, color: WAppColor.SECONDARY),
        titleLarge: _titleFont(size: 16.0, color: WAppColor.PRIMARY),
        titleMedium: _titleFont(size: 14.0, color: WAppColor.PRIMARY),
        titleSmall: _titleFont(size: 12.0, color: WAppColor.PRIMARY),
        bodyLarge:_textFont(size: 16.0),
        bodyMedium: _textFont(size: 14.0),
        bodySmall: _textFont(size: 12.0),
      ),

      // [2] AppBarTheme
      appBarTheme: AppBarTheme(
        backgroundColor: WAppColor.PRIMARY.withOpacity(0.20),
      ),

      // [3] Scaffolf
       scaffoldBackgroundColor: WAppColor.BG_COLOR, // covered by image

      // [4] BottomNavigationBarThemeData
      bottomAppBarTheme: BottomAppBarTheme(
        color: WAppColor.PRIMARY.withOpacity(0.20),
        elevation: 5.0,
        surfaceTintColor: WAppColor.TEXT_COLOR,
        shadowColor: WAppColor.SECONDARY,
      ),

      // [5] Icons
      iconTheme: const IconThemeData(
        color: WAppColor.SECONDARY,
        size: 24.0,
      ),

      // [6] TabBarTheme
      tabBarTheme: TabBarTheme(
        dividerColor: WAppColor.PRIMARY,
        dividerHeight: 0,
        labelColor: WAppColor.ACCENT,
        unselectedLabelColor: WAppColor.primarySwatch[700],
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: WAppColor.primarySwatch[700]!.withOpacity(0.2),
          shape: BoxShape.circle,
          ),
        ),

      // [7] listTileTheme
      listTileTheme: ListTileThemeData(
        tileColor: WAppColor.BG_COLOR.withOpacity(0.2),
        iconColor: WAppColor.primarySwatch[700],
        textColor: WAppColor.TEXT_COLOR,
        titleTextStyle: _titleFont(size: 18.0, color: WAppColor.accentSwatch[700]),
        subtitleTextStyle: _textFont(size: 14.0),
        selectedColor: WAppColor.ACCENT,
        selectedTileColor: WAppColor.primarySwatch[700],
        visualDensity: VisualDensity.compact,
      ),

      // [8] TextField
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: WAppColor.PRIMARY_WRITE_UP,
          fontSize: 16.0,
        ),
      ),

      // [9] PrimarySwatch - not used yet
      primarySwatch: WAppColor.primarySwatch,
      focusColor: WAppColor.ACCENT,

      // [10] textSelectionTheme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: WAppColor.ACCENT,
        selectionColor: WAppColor.ACCENT,
        selectionHandleColor: WAppColor.ACCENT,
      ),
      
    );

  }

  // [1] textTheme - Helpers
  static TextStyle _titleFont({double size = 20.0, color = WAppColor.TEXT_COLOR}) {
    return GoogleFonts.getFont(
        'Outfit',
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color
    );
  }

   static TextStyle _textFont({double size = 14.0, color = WAppColor.TEXT_COLOR}) {
    return GoogleFonts.getFont(
        'Roboto',
        fontSize: size,
        color: color
    );
  }


  /* -------------  [+] Specific widget style  ------------- */
  static TextStyle textfieldInput() {
    return TextStyle(
      color: WAppColor.primarySwatch[300],
      fontFamily: 'Roboto',
      fontSize: 18,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle textfieldHint() {
    return const TextStyle(
      color: WAppColor.PRIMARY_WRITE_UP_L1,
      fontFamily: 'Outfit',
      fontSize: 18,
      // fontWeight: FontWeight.bold
    );
  }

  // WEATHER TABS
  //  - Currently
  static TextStyle currentlyTemperature() {
    return TextStyle(
      color: WAppColor.primarySwatch[400],
      fontFamily: 'Roboto',
      fontSize: 68,
      fontWeight: FontWeight.w300,
    );
  }

   static TextStyle currentlyTemperatureUnit() {
    return TextStyle(
      color: WAppColor.primarySwatch[600],
      fontFamily: 'Roboto',
      fontSize: 26,
      // fontWeight: FontWeight.bold
    );
  }

  


}