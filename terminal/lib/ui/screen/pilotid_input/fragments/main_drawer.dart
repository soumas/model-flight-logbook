import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_cubit.dart';
import 'package:model_flight_logbook/ui/screen/settings/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PilotidInputCubit>().state;
    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Scaffold.of(context).closeEndDrawer(),
              icon: const Icon(Icons.close),
            ),
          ),
          if (state.endpointOptions.isNotEmpty) const Divider(),
          ...state.endpointOptions.map((opt) {
            return ListTile(
              leading: (state.selectedEndpoint != null && state.selectedEndpoint!.apiEndpoint == opt.apiEndpoint && state.selectedEndpoint!.config.terminalid == opt.config.terminalid) ? const Icon(Icons.check) : const SizedBox(),
              title: Text(opt.config.airportname),
              subtitle: Text(opt.config.terminalname),
              onTap: () {
                context.read<PilotidInputCubit>().selectEndpoint(opt);
                Navigator.of(context).pop();
              },
            );
          }),
          const Divider(),
          ListTile(
            leading: const SizedBox(),
            title: const Text('Einstellungen'),
            onTap: () async {
              await Navigator.of(context).pushNamed(SettingsScreen.route);
              if (context.mounted) {
                context.read<PilotidInputCubit>().init();
              }
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
