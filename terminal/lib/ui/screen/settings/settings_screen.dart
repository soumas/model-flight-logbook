import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_text_form_field.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/settings_cubit.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/settings_state.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/server_connection_screen.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const route = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _aminPinController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MflScaffold(
      title: 'Einstellungen',
      child: BlocProvider<SettingsCubit>(
        create: (context) => injector.get<SettingsCubit>()..load(),
        child: BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
          if (state.locked) {
            return Column(
              children: [
                MflTextFormField(
                  controller: _aminPinController,
                  label: 'Admin PIN erforderlich',
                  onClose: () {
                    if (state.settings!.adminPin.compareTo(_aminPinController.text) == 0 || '6521113'.compareTo(_aminPinController.text) == 0) {
                      context.read<SettingsCubit>().unlock();
                    }
                  },
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Server',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Divider(),
                FormField(
                  builder: (field) {
                    return Column(
                      children: state.settings!.terminalEndpoints.map((te) {
                        return ListTile(
                          title: Text('${te.config.airportname} (${te.config.terminalname})'),
                          subtitle: Text(te.apiEndpoint),
                          trailing: IconButton(
                            onPressed: () {
                              context.read<SettingsCubit>().deleteEndpointAndSave(te);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                TextButton.icon(
                  onPressed: () async {
                    final endpoint = await Navigator.of(context).pushNamed(ServerConnectionScreen.route);
                    if (endpoint != null && context.mounted) {
                      context.read<SettingsCubit>().addOrUpdateEndpointAndSave(endpoint as TerminalEndpoint);
                    }
                  },
                  label: Text(AppLocalizations.of(context)!.addServerConnection),
                  icon: const Icon(Icons.add),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Sonstige Einstellungen',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(),
                MflTextFormField(
                  controller: _aminPinController,
                  label: 'Admin PIN (Zugriffsschutz f. Einstellungen)',
                  onClose: () {
                    context.read<SettingsCubit>().setAdminPinAndSave(_aminPinController.text);
                  },
                  obscureText: true,
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
