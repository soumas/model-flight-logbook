import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dronedpace_logbook_terminal/injector.dart';
import 'package:dronedpace_logbook_terminal/l10n/generated/app_localizations.dart';
import 'package:dronedpace_logbook_terminal/ui/screen/settings/settings_screen.dart';
import 'package:dronedpace_logbook_terminal/ui/screen/time_punch/time_punch_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await initInjector();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routes: {
        TimePunchScreen.route: (context) => const TimePunchScreen(),
        SettingsScreen.route: (context) => const SettingsScreen(),
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
