import 'package:intl/intl.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/fragments/end_flight_session_form.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/settings/settings_screen.dart';
import 'package:model_flight_logbook/ui/screen/dashboard/dashboard_screen.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/server_connection_screen.dart';
import 'package:model_flight_logbook/ui/utils/mfl_scroll_behavior.dart';
import 'package:model_flight_logbook/ui/utils/mfl_theme.dart';

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
        PilotStatusScreen.route: (context) => const PilotStatusScreen(),
        ServerConnectionScreen.route: (context) => const ServerConnectionScreen(),
        EndFlightSessionForm.route: (context) => const EndFlightSessionForm(),
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
