import 'package:flutter/material.dart';

const kColorPrimary = Colors.lightBlue;
final kColorOnPrimary = Colors.grey.shade100;
const kColorBackground = Colors.black;
final kColorCard = Colors.grey.shade600.withAlpha((256 * 0.8).toInt());
const kColorFontMain = Colors.white;
final kColorFontSub = Colors.grey.shade300;
const kColorInfo = Color(0xFF79B7E0);
const kColorWarning = Color(0xFFDCAF1F);
const kColorError = Color(0xFFCC0000);

final kTextThemeBodySmall = ThemeData.dark().textTheme.bodySmall!.copyWith(fontSize: 12, color: kColorFontMain);
final kTextThemeBodyMedium = ThemeData.dark().textTheme.bodyMedium!.copyWith(fontSize: 16, color: kColorFontMain);
final kTextThemeBodyLarge = ThemeData.dark().textTheme.bodyLarge!.copyWith(fontSize: 20, color: kColorFontMain);

final mflThemeData = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.transparent,
  textTheme: ThemeData.dark().textTheme.copyWith(
        bodySmall: kTextThemeBodySmall,
        bodyMedium: kTextThemeBodyMedium,
        bodyLarge: kTextThemeBodyLarge,
        titleSmall: kTextThemeBodySmall,
        titleMedium: kTextThemeBodyMedium,
        titleLarge: kTextThemeBodyLarge,
        labelSmall: kTextThemeBodySmall,
        labelMedium: kTextThemeBodyMedium,
        labelLarge: kTextThemeBodyLarge,
        headlineSmall: kTextThemeBodySmall,
        headlineMedium: kTextThemeBodyMedium,
        headlineLarge: kTextThemeBodyLarge,
        displaySmall: kTextThemeBodySmall,
        displayMedium: kTextThemeBodyMedium,
        displayLarge: kTextThemeBodyLarge,
      ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // shadowColor: Colors.white,
      // elevation: 4.0,
      backgroundColor: kColorPrimary,
      foregroundColor: kColorOnPrimary,
      iconColor: kColorOnPrimary,
      // iconSize: 38,
      // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: kColorCard,
    filled: true,
    border: const OutlineInputBorder(),
    errorStyle: kTextThemeBodyMedium.copyWith(color: Colors.red),
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: kTextThemeBodyMedium,
    subtitleTextStyle: kTextThemeBodySmall,
  ),
  appBarTheme: ThemeData.dark().appBarTheme.copyWith(
        foregroundColor: kColorFontMain,
        scrolledUnderElevation: 0,
        color: kColorBackground.withAlpha(128),
        iconTheme: const IconThemeData(
          size: 38,
          color: kColorFontMain,
        ),
      ),
  cardTheme: CardThemeData(color: kColorCard),
);
