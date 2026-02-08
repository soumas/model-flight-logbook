import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/endpoint_list/menu_endpoint_list.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:mfl_terminal/src/screens/settings_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(onPressed: () => Scaffold.of(context).closeEndDrawer(), icon: const Icon(Icons.chevron_right_rounded)),
          ),
          const MenuEndpointList(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.mainMenuSettings),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(SettingsScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
