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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            side: const BorderSide(
              color: Colors.white54,
              width: 2,
            ),
            backgroundColor: Colors.green,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontSize: 16),
          ),
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
