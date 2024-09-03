import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook_terminal/injector.dart';
import 'package:model_flight_logbook_terminal/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook_terminal/ui/screen/settings/cubit/local_settings_cubit.dart';
import 'package:model_flight_logbook_terminal/ui/screen/settings/cubit/local_settings_state.dart';

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
            } else if (state.settings != null) {
              return ListView(
                children: [
                  TextFormField(
                    initialValue: state.settings!.apiEndpoint,
                    decoration: const InputDecoration(label: Text('Api Endpoint')),
                    onChanged: (value) {
                      context.read<LocalSettingsCubit>().setApiEndpoint(value);
                    },
                  ),
                  TextFormField(
                    initialValue: state.settings!.apiKey,
                    decoration: const InputDecoration(label: Text('Api Key')),
                    onChanged: (value) {
                      context.read<LocalSettingsCubit>().setApiKey(value);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LocalSettingsCubit>().save();
                    },
                    child: const Text('save'),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
