import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/settings_cubit.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/settings_state.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/server_connection_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: BlocProvider<SettingsCubit>(
        create: (context) => injector.get<SettingsCubit>()..load(),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state.loading) {
              return const CircularProgressIndicator();
            } else if (state.error != null) {
              return Text('Error: ${state.error.toString()}');
            } else {
              return SizedBox(
                width: 460,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(
                    builder: (context) {
                      if (state.locked) {
                        return TextFormField(
                          decoration: const InputDecoration(label: Text('Enter Admin PIN')),
                          onChanged: (value) {
                            if (state.settings!.adminPin.compareTo(value) == 0) {
                              context.read<SettingsCubit>().unlock();
                            }
                          },
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Serververbindungen',
                                style: Theme.of(context).textTheme.titleMedium,
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
                                label: const Text('Serververbindung hinzufügen'),
                                icon: const Icon(Icons.add),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Sonstige Einstellungen',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const Divider(),
                              TextFormField(
                                initialValue: state.settings!.adminPin,
                                decoration: const InputDecoration(label: Text('Admin PIN')),
                                onChanged: (value) {
                                  context.read<SettingsCubit>().setAdminPinAndSave(value);
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
