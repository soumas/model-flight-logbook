import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mfl_terminal/domain/entities/settings.dart';
import 'package:mfl_terminal/domain/entities/terminal_config.dart';
import 'package:mfl_terminal/domain/entities/terminal_endpoint.dart';
import 'package:mfl_terminal/domain/enums/terminal_type.dart';
import 'package:mfl_terminal/domain/repositories/local_storage_repo.dart';
import 'package:mfl_terminal/injector.dart';
import 'package:mfl_terminal/l10n/generated/app_localizations.dart';
import 'package:mfl_terminal/ui/screen/settings/settings_screen.dart';
import 'package:mfl_terminal/ui/screen/dashboard/dashboard_screen.dart';
import 'package:mfl_terminal/ui/screen/server_connection/server_connection_screen.dart';
import 'package:mfl_terminal/ui/utils/mfl_device_info.dart';
import 'package:mfl_terminal/ui/utils/mfl_scroll_behavior.dart';
import 'package:mfl_terminal/ui/utils/mfl_theme.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'DE-de';
  await initInjector();
  await injector.get<MflDeviceInfo>().init();

  if (args.isNotEmpty && args[0] == 'add-endpoint') {
    final currentSettings = await injector.get<LocalStorageRepo>().loadSettings();
    if (currentSettings.terminalEndpoints.isEmpty) {
      // dirty hack to add an endpoint from command line for easier setup
      final url = args[1];
      final pwd = args[2];
      final terminalId = args[3];
      TerminalEndpoint endpoint = TerminalEndpoint(
        apiEndpoint: url,
        apiKey: pwd,
        config: TerminalConfig(
            terminalid: terminalId,
            airportname: 'auto added',
            maxAltitudeM: 0,
            maxAltitudeWithoutObserverM: 0,
            maxNumFlights: 0,
            showPilotIDOnDashboard: false,
            terminalname: 'auto added',
            terminaltype: TerminalType.multiuser),
      );
      await injector.get<LocalStorageRepo>().saveSettings(Settings(adminPin: '', terminalEndpoints: [endpoint]));
    }
  }

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
