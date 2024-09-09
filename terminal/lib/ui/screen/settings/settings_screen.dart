import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/local_settings_cubit.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/local_settings_state.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Card(
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
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  initialValue: state.settings!.apiEndpoint,
                                  decoration: const InputDecoration(label: Text('Api Endpoint')),
                                  onChanged: (value) {
                                    context.read<LocalSettingsCubit>().setApiEndpoint(value);
                                  },
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                          child: ListView(
                                            children: [
                                              VirtualKeyboard(
                                                textColor: Colors.white,
                                                defaultLayouts: [VirtualKeyboardDefaultLayouts.English],
                                                type: VirtualKeyboardType.Alphanumeric,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                TextFormField(
                                  initialValue: state.settings!.apiKey,
                                  decoration: const InputDecoration(label: Text('Api Key')),
                                  onChanged: (value) {
                                    context.read<LocalSettingsCubit>().setApiKey(value);
                                  },
                                ),
                                TextFormField(
                                  initialValue: state.settings!.adminPin,
                                  decoration: const InputDecoration(label: Text('Admin PIN')),
                                  onChanged: (value) {
                                    context.read<LocalSettingsCubit>().setAdminPin(value);
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await context.read<LocalSettingsCubit>().save();
                                    if (context.mounted) Navigator.of(context).pop();
                                  },
                                  child: const Text('save'),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
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
