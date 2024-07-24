import 'dart:io';

import 'package:flutter/material.dart';

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
            title: const Text('Manuell stempeln'),
            onTap: () {
            },
          ),          
          ListTile(
            title: const Text('Administration'),
            onTap: () {
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
