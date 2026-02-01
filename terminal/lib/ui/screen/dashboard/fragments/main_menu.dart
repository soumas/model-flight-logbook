import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfl_terminal/ui/screen/dashboard/cubit/dashboard_cubit.dart';
import 'package:mfl_terminal/ui/screen/settings/settings_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DashboardCubit>();
    final state = cubit.state;
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
              leading: (state.selectedEndpoint != null &&
                      state.selectedEndpoint!.apiEndpoint == opt.apiEndpoint &&
                      state.selectedEndpoint!.config.terminalid == opt.config.terminalid)
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank),
              title: Text(opt.config.airportname),
              subtitle: Text(opt.config.terminalname),
              onTap: () {
                Navigator.of(context).pop();
                context.read<DashboardCubit>().selectEndpoint(opt);
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
              cubit.init();
            },
          ),
        ],
      ),
    );
  }
}
