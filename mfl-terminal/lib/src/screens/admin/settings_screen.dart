import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_scaffold.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/endpoint_list/admin_endpoint_list.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return MflScaffold(
      showBackgroundImage: false,
      title: AppLocalizations.of(context)!.mainMenuSettings,
      child1: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.settingsEndpoints, style: Theme.of(context).textTheme.headlineLarge),
          const Divider(),
          const AdminEndpointList(),
          const SizedBox(height: 32),
          Text(AppLocalizations.of(context)!.settingsAdminpin, style: Theme.of(context).textTheme.headlineLarge),
          const Divider(),
          Text('TODO'),
          const SizedBox(height: 32),
          Text(AppLocalizations.of(context)!.settingsOthers, style: Theme.of(context).textTheme.headlineLarge),
          const Divider(),
          Text('TODO'),
        ],
      ),
    );
  }
}
