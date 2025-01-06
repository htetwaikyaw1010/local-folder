import 'package:flutter/material.dart';
import '../core/constant/dimesions.dart';
import 'master_colors.dart';
import 'master_config.dart';

ThemeData themeData(ThemeData baseTheme) {
  //final baseTheme = ThemeData.light();

  if (baseTheme.brightness == Brightness.dark) {
    MasterColors.loadColor2(false);

    // Dark Theme
    return baseTheme.copyWith(
      // primaryColor: MasterColors.primary500,
      // primaryColorDark: MasterColors.baseColor,
      // primaryColorLight: MasterColors.primaryDarkWhite,
      // scaffoldBackgroundColor: MasterColors.baseColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
            fontFamily: MasterConfig.default_font_family),
        displayMedium: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
            fontFamily: MasterConfig.default_font_family),
        displaySmall: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
            fontFamily: MasterConfig.default_font_family),
        headlineMedium: TextStyle(
          color: Color.fromRGBO(254, 242, 0, 1),
          fontFamily: MasterConfig.default_font_family,
        ),
        headlineSmall: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
            fontFamily: MasterConfig.default_font_family,
            fontWeight: FontWeight.bold),
        titleLarge: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
            fontFamily: MasterConfig.default_font_family),
        titleMedium: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
            fontFamily: MasterConfig.default_font_family,
            fontWeight: FontWeight.bold),
        titleSmall: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
            fontFamily: MasterConfig.default_font_family,
            fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
          color: Color.fromRGBO(254, 242, 0, 1),
          fontFamily: MasterConfig.default_font_family,
        ),
        bodyMedium: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
            fontFamily: MasterConfig.default_font_family,
            fontWeight: FontWeight.bold),
        labelLarge: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
            fontFamily: MasterConfig.default_font_family),
        bodySmall: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
            fontFamily: MasterConfig.default_font_family),
        labelSmall: TextStyle(
            fontSize: Dimesion.font12,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(254, 242, 0, 1)),
      ),
      iconTheme: IconThemeData(color: MasterColors.primaryDarkWhite),
      // appBarTheme:
      //     AppBarTheme(color: MasterColors.baseColor),
      // //coreBackgroundColor),
    );
  } else {
    MasterColors.loadColor2(true);
    // White Theme
    return baseTheme.copyWith(
      primaryColor: MasterColors.primary500,
      primaryColorDark: MasterColors.primary900,
      primaryColorLight: MasterColors.primary50,
      // scaffoldBackgroundColor: MasterColors.baseColor,
      textTheme: TextTheme(
          displayLarge: TextStyle(
              color: MasterColors.mainColor,
              fontFamily: MasterConfig.default_font_family),
          displayMedium: TextStyle(
              color: MasterColors.mainColor,
              fontFamily: MasterConfig.default_font_family),
          displaySmall: TextStyle(
              color: MasterColors.mainColor,
              fontFamily: MasterConfig.default_font_family),
          headlineMedium: TextStyle(
              color: MasterColors.mainColor,
              fontSize: 24,
              fontFamily: MasterConfig.default_font_family,
              fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(
              color: MasterColors.mainColor,
              fontSize: 20,
              fontFamily: MasterConfig.default_font_family,
              fontWeight: FontWeight.w600),
          titleLarge: TextStyle(
              color: MasterColors.mainColor,
              fontWeight: FontWeight.w600,
              fontFamily: MasterConfig.default_font_family),
          titleMedium: TextStyle(
              color: MasterColors.mainColor,
              fontFamily: MasterConfig.default_font_family,
              fontWeight: FontWeight.bold),
          titleSmall: TextStyle(
              color: MasterColors.mainColor,
              fontFamily: MasterConfig.default_font_family,
              fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(
              color: MasterColors.mainColor,
              fontFamily: MasterConfig.default_font_family,
              fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(
              color: MasterColors.mainColor,
              fontFamily: MasterConfig.default_font_family,
              fontWeight: FontWeight.bold),
          labelLarge: TextStyle(
              color: MasterColors.mainColor,
              fontFamily: MasterConfig.default_font_family),
          bodySmall: TextStyle(
              color: MasterColors.mainColor,
              fontFamily: MasterConfig.default_font_family),
          labelSmall: TextStyle(
              fontSize: Dimesion.font12,
              fontWeight: FontWeight.w400,
              color: MasterColors.mainColor)),
      iconTheme: IconThemeData(color: MasterColors.secondary800),
      appBarTheme: AppBarTheme(  
        backgroundColor: MasterColors.mainColor,
        toolbarHeight: 60,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(254, 242, 0, 1),
        ),
        actionsIconTheme: IconThemeData(color: Color.fromRGBO(254, 242, 0, 1)),
      ),
    ); //coreBackgroundColor));
  }
}
