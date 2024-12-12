import 'package:intl/intl.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/settings/settings_screen.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/pilotid_input_screen.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/server_connection_screen.dart';

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
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodySmall: ThemeData.dark().textTheme.bodySmall!.copyWith(fontSize: 16),
              bodyMedium: ThemeData.dark().textTheme.bodyMedium!.copyWith(fontSize: 22),
              bodyLarge: ThemeData.dark().textTheme.bodyLarge!.copyWith(fontSize: 28),
              headlineSmall: ThemeData.dark().textTheme.headlineSmall!.copyWith(fontSize: 16),
              headlineMedium: ThemeData.dark().textTheme.headlineMedium!.copyWith(fontSize: 28),
              headlineLarge: ThemeData.dark().textTheme.headlineLarge!.copyWith(fontSize: 42),
              labelSmall: ThemeData.dark().textTheme.labelSmall!.copyWith(fontSize: 16),
              labelMedium: ThemeData.dark().textTheme.labelMedium!.copyWith(fontSize: 24),
              labelLarge: ThemeData.dark().textTheme.labelLarge!.copyWith(fontSize: 32, fontWeight: FontWeight.w500),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.white,
            elevation: 8,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey.withAlpha(30),
          filled: true,
          border: const OutlineInputBorder(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        PilotidInputScreen.route: (context) => const PilotidInputScreen(),
        SettingsScreen.route: (context) => const SettingsScreen(),
        PilotStatusScreen.route: (context) => const PilotStatusScreen(),
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
