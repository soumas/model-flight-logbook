import 'package:intl/intl.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/fragments/end_flight_session_form.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/settings/settings_screen.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/pilotid_input_screen.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/server_connection_screen.dart';
import 'package:model_flight_logbook/ui/utils/mfl_scroll_behavior.dart';

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
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodySmall: ThemeData.dark().textTheme.bodySmall!.copyWith(fontSize: 18),
              bodyMedium: ThemeData.dark().textTheme.bodyMedium!.copyWith(fontSize: 28),
              bodyLarge: ThemeData.dark().textTheme.bodyLarge!.copyWith(fontSize: 38, fontWeight: FontWeight.bold),
              headlineSmall: ThemeData.dark().textTheme.headlineSmall!.copyWith(fontSize: 32),
              headlineMedium: ThemeData.dark().textTheme.headlineMedium!.copyWith(fontSize: 42),
              headlineLarge: ThemeData.dark().textTheme.headlineLarge!.copyWith(fontSize: 52),
              labelSmall: ThemeData.dark().textTheme.labelSmall!.copyWith(fontSize: 16),
              labelMedium: ThemeData.dark().textTheme.labelMedium!.copyWith(fontSize: 24),
              labelLarge: ThemeData.dark().textTheme.labelLarge!.copyWith(fontSize: 32, fontWeight: FontWeight.w500),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.white,
            elevation: 4.0,
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.yellow,
            iconColor: Colors.yellow,
            iconSize: 38,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey.withAlpha(30),
          filled: true,
          border: const OutlineInputBorder(),
          errorStyle: ThemeData.dark().textTheme.labelMedium!.copyWith(
                fontSize: 24,
                color: Colors.red,
              ),
        ),
        listTileTheme: ListTileThemeData(
          titleTextStyle: ThemeData.dark().textTheme.headlineLarge!.copyWith(fontSize: 28),
          subtitleTextStyle: ThemeData.dark().textTheme.headlineLarge!.copyWith(fontSize: 18),
        ),
        iconTheme: ThemeData.dark().iconTheme.copyWith(size: 38),
        dialogBackgroundColor: Colors.blueGrey,
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(foregroundColor: Colors.grey, iconTheme: const IconThemeData(size: 38, color: Colors.grey)),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        PilotidInputScreen.route: (context) => const PilotidInputScreen(),
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
