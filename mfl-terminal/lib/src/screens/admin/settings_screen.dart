import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_scaffold.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/endpoint_list/admin_endpoint_list.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';
import 'package:mfl_terminal/src/screens/admin/endpoint_detail_screen.dart';

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
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EndpointDetailScreen.route);
            },
            child: Text(AppLocalizations.of(context)!.settingsAddEndpoint),
          ),
        ],
      ),
    );
  }
}
