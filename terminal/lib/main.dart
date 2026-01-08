import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mfl_terminal/injector.dart';
import 'package:mfl_terminal/l10n/generated/app_localizations.dart';
import 'package:mfl_terminal/ui/screen/settings/settings_screen.dart';
import 'package:mfl_terminal/ui/screen/dashboard/dashboard_screen.dart';
import 'package:mfl_terminal/ui/screen/server_connection/server_connection_screen.dart';
import 'package:mfl_terminal/ui/utils/mfl_scroll_behavior.dart';
import 'package:mfl_terminal/ui/utils/mfl_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'DE-de';
  await initInjector();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MflScrollBehavior(),
      theme: mflThemeData,
      debugShowCheckedModeBanner: false,
      routes: {
        DashboardScreen.route: (context) => const DashboardScreen(),
        SettingsScreen.route: (context) => const SettingsScreen(),
        ServerConnectionScreen.route: (context) => const ServerConnectionScreen(),
      },
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
