import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            } else if (state.error != null) {
              return Text('Error: ${state.error.toString()}');
            } else {
              return SizedBox(
                width: 460,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    return Column(
                      children: [
                        TextFormField(
                          initialValue: state.apiEndpoint,
                          decoration: const InputDecoration(label: Text('Api Endpoint')),
                          onChanged: (value) {
                            context.read<ServerConnectionCubit>().setApiEndpoint(value);
                          },
                        ),
                        TextFormField(
                          initialValue: state.apiKey,
                          decoration: const InputDecoration(label: Text('Api Key')),
                          onChanged: (value) {
                            context.read<ServerConnectionCubit>().setApiKey(value);
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<ServerConnectionCubit>().connect();
                          },
                          child: Text('Verbinden'),
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
