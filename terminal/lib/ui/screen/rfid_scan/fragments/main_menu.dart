import 'dart:io';

import 'package:flutter/material.dart';
import 'package:model_flight_logbook_terminal/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook_terminal/ui/screen/settings/settings_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              Navigator.of(context).pushNamed(SettingsScreen.route);
            },
          ),
          ListTile(
            title: const Text('Programm Beenden'),
            onTap: () => exit(0),
          ),
        ],
      ), // Populate the Drawer in the next step.
    );
  }
}
