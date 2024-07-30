import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_time_punch_terminal/injector.dart';
import 'package:simple_time_punch_terminal/l10n/generated/app_localizations.dart';
import 'package:simple_time_punch_terminal/ui/screen/settings/cubit/local_settings_cubit.dart';
import 'package:simple_time_punch_terminal/ui/screen/settings/cubit/local_settings_state.dart';

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
                    initialValue: state.settings!.kimaiEndpoint,
                    decoration: const InputDecoration(label: Text('Kimai endpoint')),
                    onChanged: (value) {
                      context.read<LocalSettingsCubit>().setKimaiEndpoint(value);
                    },
                  ),
                  TextFormField(
                    initialValue: state.settings!.kimaiToken,
                    decoration: const InputDecoration(label: Text('Kimai token')),
                    onChanged: (value) {
                      context.read<LocalSettingsCubit>().setKimaiToken(value);
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
