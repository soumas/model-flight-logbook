import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_scaffold.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/add_endpoint_form/add_endpoint_form.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/endpoint_list/admin_endpoint_list.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const route = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MflScaffold(
      showBackgroundImage: false,
      title: AppLocalizations.of(context)!.mainMenuSettings,
      child1: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Server', style: Theme.of(context).textTheme.headlineLarge),
          const Divider(),
          const AdminEndpointList(),
          const AddEndpointForm(),
        ],
      ),
    );
  }
}
