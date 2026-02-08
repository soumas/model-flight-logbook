import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/common/utils/mfl_device_info.dart';
import 'package:mfl_terminal/src/common/utils/mfl_scroll_behavior.dart';
import 'package:mfl_terminal/src/common/utils/mfl_theme.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:mfl_terminal/src/screens/dashboard_screen.dart';
import 'package:mfl_terminal/src/screens/settings_screen.dart';

class MflApp extends StatelessWidget {
  const MflApp({super.key});

  static Future<void> prepare() async {
    Intl.defaultLocale = 'de_DE';
    MflInjector.init();
    await MflDeviceInfo.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MflScrollBehavior(),
      theme: mflThemeData,
      debugShowCheckedModeBanner: false,
      routes: {DashboardScreen.route: (context) => const DashboardScreen(), SettingsScreen.route: (context) => const SettingsScreen()},
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
    );
  }
}
