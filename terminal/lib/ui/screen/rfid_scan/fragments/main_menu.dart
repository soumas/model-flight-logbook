import 'dart:io';

import 'package:flutter/material.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/local_settings/local_settings_screen.dart';

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
              Navigator.of(context).pushNamed(LocalSettingsScreen.route);
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
