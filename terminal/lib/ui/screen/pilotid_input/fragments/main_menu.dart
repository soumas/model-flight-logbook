import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_cubit.dart';
import 'package:model_flight_logbook/ui/screen/settings/settings_screen.dart';
import 'package:model_flight_logbook/ui/utils/mfl_paddings.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PilotidInputCubit>().state;
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Scaffold.of(context).closeEndDrawer(),
              icon: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          if (state.endpointOptions.isNotEmpty) const Divider(),
          ...state.endpointOptions.map((opt) {
            return ListTile(
              leading: (state.selectedEndpoint != null && state.selectedEndpoint!.apiEndpoint == opt.apiEndpoint && state.selectedEndpoint!.config.terminalid == opt.config.terminalid) ? const Icon(Icons.check_box_outlined) : const Icon(Icons.check_box_outline_blank),
              title: Text(opt.config.airportname),
              subtitle: Text(opt.config.terminalname),
              onTap: () {
                Navigator.of(context).pop();
                context.read<PilotidInputCubit>().selectEndpoint(opt);
              },
            );
          }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Einstellungen'),
            onTap: () async {
              Navigator.of(context).pop();
              await Navigator.of(context).pushNamed(SettingsScreen.route);
              if (context.mounted) {
                context.read<PilotidInputCubit>().init();
              }
            },
          ),
          const Divider(),
          MflPaddings.verticalSmall(context),
          Opacity(
            opacity: 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  kAssetMflLogoSlim,
                  height: 40,
                ),
                Text(
                  'Model Flight Logbook',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          MflPaddings.verticalSmall(context),
        ],
      ),
    );
  }
}
