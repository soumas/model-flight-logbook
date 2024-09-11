import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/local_settings/cubit/local_settings_cubit.dart';
import 'package:model_flight_logbook/ui/screen/local_settings/cubit/local_settings_state.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/server_connection_screen.dart';

class LocalSettingsScreen extends StatelessWidget {
  const LocalSettingsScreen({super.key});

  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: BlocProvider<LocalSettingsCubit>(
        create: (context) => injector.get<LocalSettingsCubit>()..load(),
        child: BlocBuilder<LocalSettingsCubit, LocalSettingsState>(
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
                              context.read<LocalSettingsCubit>().unlock();
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
                                  return const Column(
                                    children: [
                                      ListTile(
                                        title: Text('MSGU Modellflugplatz (RFID Terminal)'),
                                        subtitle: Text('https://msgu.at/termianl/23lso/'),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(ServerConnectionScreen.route).then((terminalendpoint) {
                                    // TODO: save new or modified endpoint
                                  });
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
                                  context.read<LocalSettingsCubit>().setAdminPinAndSave(value);
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
