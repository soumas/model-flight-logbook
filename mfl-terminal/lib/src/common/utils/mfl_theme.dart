import 'package:flutter/material.dart';

const kColorPrimary = Color(0xFF419ABA);
final kColorOnPrimary = Colors.grey.shade100;
const kColorBackground = Colors.black;
final kColorCard = Colors.grey.shade600.withAlpha((256 * 0.8).toInt());
// final kColorCard = kColorBackground.withAlpha(128);
const kColorFontMain = Colors.white;
final kColorFontSub = Colors.grey.shade300;
final kColorInputBg = Colors.grey.shade800;

const kColorSuccess = Colors.green;
const kColorInfo = Color(0xFF79B7E0);
const kColorWarning = Color(0xFFDCAF1F);
const kColorError = Color(0xFFCC0000);

final kTextThemeBodySmall = ThemeData.dark().textTheme.bodySmall!.copyWith(fontSize: 12, color: kColorFontMain);
final kTextThemeBodyMedium = ThemeData.dark().textTheme.bodyMedium!.copyWith(fontSize: 16, color: kColorFontMain);
final kTextThemeBodyLarge = ThemeData.dark().textTheme.bodyLarge!.copyWith(fontSize: 20, color: kColorFontMain);

const kCornderRadius = 0.0;

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
      elevation: 1.0,
      backgroundColor: kColorPrimary,
      foregroundColor: kColorOnPrimary,
      iconColor: kColorOnPrimary,
      iconSize: 24,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCornderRadius)),
      textStyle: kTextThemeBodyLarge,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: kColorInputBg,
    filled: true,
    border: const OutlineInputBorder(),
    errorStyle: kTextThemeBodyMedium.copyWith(color: kColorError, fontWeight: FontWeight.bold),
  ),
  listTileTheme: ListTileThemeData(titleTextStyle: kTextThemeBodyMedium, subtitleTextStyle: kTextThemeBodySmall),
  appBarTheme: ThemeData.dark().appBarTheme.copyWith(
    foregroundColor: kColorFontMain,
    scrolledUnderElevation: 0,
    //backgroundColor: kColorBackground.withAlpha(128),
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(size: 38, color: kColorFontMain),
  ),
  cardTheme: CardThemeData(
    color: kColorCard,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCornderRadius)),
  ),
  dialogTheme: DialogThemeData(
    elevation: 6,
    shadowColor: kColorCard,
    alignment: Alignment.center,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kCornderRadius)),
    titleTextStyle: kTextThemeBodyLarge,
    contentTextStyle: kTextThemeBodyMedium,
  ),
);
