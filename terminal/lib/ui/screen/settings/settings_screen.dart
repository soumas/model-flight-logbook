import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/settings_cubit.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/settings_state.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/server_connection_screen.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const route = '/settings';

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
                TextFormField(
                  decoration: const InputDecoration(label: Text('Admin PIN erforderlich')),
                  onChanged: (value) {
                    if (state.settings!.adminPin.compareTo(value) == 0) {
                      context.read<SettingsCubit>().unlock();
                    }
                  },
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Server',
                          style: Theme.of(context).textTheme.titleLarge,
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
                          label: const Text('Server hinzufügen'),
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sonstige Einstellungen',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider(),
                        TextFormField(
                          initialValue: state.settings!.adminPin,
                          decoration: const InputDecoration(label: Text('Admin PIN (Zugriffsschutz f. Einstellungen)')),
                          onChanged: (value) {
                            context.read<SettingsCubit>().setAdminPinAndSave(value);
                          },
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
