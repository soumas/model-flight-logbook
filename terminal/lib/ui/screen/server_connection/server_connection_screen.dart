import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/cubit/server_connection_cubit.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/cubit/server_connection_state.dart';

class ServerConnectionScreen extends StatelessWidget {
  const ServerConnectionScreen({super.key});

  static const route = '/serverConnection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addServerConnection),
      ),
      body: BlocProvider<ServerConnectionCubit>(
        create: (context) => injector.get<ServerConnectionCubit>()..init(),
        child: BlocConsumer<ServerConnectionCubit, ServerConnectionState>(
          listener: (context, state) {
            if (state.result != null) {
              Navigator.of(context).pop(state.result!);
            }
          },
          builder: (context, state) {
            if (state.loading) {
              return const CircularProgressIndicator();
            } else {
              return SizedBox(
                width: 460,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    return Column(
                      children: [
                        if (state.error != null) Text('Error: ${state.error.toString()}'),
                        if (state.configOptions.isEmpty)
                          TextFormField(
                            initialValue: state.selectedApiEndpoint,
                            decoration: const InputDecoration(label: Text('Api Endpoint')),
                            onChanged: (value) {
                              context.read<ServerConnectionCubit>().selectApiEndpoint(value);
                            },
                            readOnly: state.configOptions.isNotEmpty,
                          ),
                        if (state.configOptions.isEmpty)
                          ElevatedButton(
                            onPressed: () {
                              context.read<ServerConnectionCubit>().loadConfigurations();
                            },
                            child: Text('Weiter'),
                          ),
                        if (state.configOptions.isNotEmpty)
                          DropdownButtonFormField(
                            value: state.selectedConfig,
                            items: state.configOptions
                                .map(
                                  (opt) => DropdownMenuItem<TerminalConfig>(
                                    value: opt,
                                    child: Text('${opt.airportname} (${opt.terminalname})'),
                                  ),
                                )
                                .toList(),
                            onChanged: <TerminalConfig>(value) {
                              context.read<ServerConnectionCubit>().selectTerminalconfig(value);
                            },
                          ),
                        if (state.selectedConfig != null)
                          TextFormField(
                            initialValue: state.selectedApiKey,
                            decoration: const InputDecoration(label: Text('Api Key')),
                            onChanged: (value) {
                              context.read<ServerConnectionCubit>().selectApiKey(value);
                            },
                          ),
                        if (state.selectedConfig != null && state.selectedConfig!.terminaltype == 'singleuser')
                          TextFormField(
                            initialValue: state.selectedApiKey,
                            decoration: const InputDecoration(label: Text('Pilot-ID')),
                            onChanged: (value) {
                              context.read<ServerConnectionCubit>().selectPilotid(value);
                            },
                          ),
                        if (state.selectedConfig != null)
                          ElevatedButton(
                            onPressed: () {
                              context.read<ServerConnectionCubit>().submit();
                            },
                            child: Text('Prüfen und speichern'),
                          ),
                      ],
                    );
                  }),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
