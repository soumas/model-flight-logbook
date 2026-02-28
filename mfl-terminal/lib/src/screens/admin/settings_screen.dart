import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/toast.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_scaffold.dart';
import 'package:mfl_terminal/src/features/adminpin/ui/adminpin_unlock_form.dart';
import 'package:mfl_terminal/src/features/adminpin/ui/adminpin_unlocked_state.dart';
import 'package:mfl_terminal/src/features/adminpin/ui/adminpin_update_form.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/endpoint_list/admin_endpoint_list.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return MflScaffold(
      showBackgroundImage: false,
      title: AppLocalizations.of(context)!.mainMenuSettings,
      child1: ListenableProvider<AdminpinUnlockedState>(
        create: (BuildContext context) => AdminpinUnlockedState()..init(),
        child: Consumer<AdminpinUnlockedState>(
          builder: (BuildContext context, AdminpinUnlockedState value, Widget? child) {
            return Stack(
              children: [
                Offstage(
                  offstage: !value.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.settingsEndpoints, style: Theme.of(context).textTheme.headlineLarge),
                      const Divider(),
                      const AdminEndpointList(),
                      const SizedBox(height: 30),
                      Text(AppLocalizations.of(context)!.settingsAdminpin, style: Theme.of(context).textTheme.headlineLarge),
                      const Divider(),
                      const AdminpinUpdateForm(),
                      const SizedBox(height: 30),
                      Text(AppLocalizations.of(context)!.settingsOthers, style: Theme.of(context).textTheme.headlineLarge),
                      const Divider(),
                      ElevatedButton(
                        onPressed: () {
                          try {
                            exit(0);
                          } on UnsupportedError {
                            Toast.error(context: context, message: AppLocalizations.of(context)!.functionNotSupported);
                          }
                        },
                        child: const Text('Terminal beenden'),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Offstage(offstage: value.value, child: const AdminpinUnlockForm()),
              ],
            );
          },
        ),
      ),
    );
  }
}
