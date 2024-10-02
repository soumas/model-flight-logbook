import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';
import 'package:model_flight_logbook/domain/enums/terminal_type.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/mfl_text_form_field.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/cubit/server_connection_cubit.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/cubit/server_connection_state.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_message.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';

class ServerConnectionScreen extends StatefulWidget {
  const ServerConnectionScreen({super.key});

  static const route = '/server';

  @override
  State<ServerConnectionScreen> createState() => _ServerConnectionScreenState();
}

class _ServerConnectionScreenState extends State<ServerConnectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _serverUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return MflScaffold(
      title: AppLocalizations.of(context)!.addServerConnection,
      child: BlocProvider<ServerConnectionCubit>(
        create: (context) => injector.get<ServerConnectionCubit>()..init(localizations),
        child: BlocConsumer<ServerConnectionCubit, ServerConnectionState>(
          listener: (context, state) {
            if (state.result != null) {
              Navigator.of(context).pop(state.result!);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  if (state.error != null)
                    MflMessage(
                      text: state.error.toString(),
                      severity: MflMessageSeverity.error,
                    ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MflTextFormField(
                            controller: _serverUrlController,
                            label: 'Server URL',
                            //initialValue: state.selectedApiEndpoint,
                            suffixIcon: (state.configOptions.isEmpty)
                                ? TextButton.icon(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<ServerConnectionCubit>().loadConfigurations(_serverUrlController.text);
                                      }
                                    },
                                    label: const Text('Weiter'),
                                    icon: const Icon(Icons.arrow_forward),
                                    iconAlignment: IconAlignment.end,
                                  )
                                : null,
                            readOnly: state.configOptions.isNotEmpty,
                            validator: (value) {
                              if (!Uri.parse(value ?? '').isAbsolute) {
                                return 'URL ungültig';
                              }
                              return null;
                            },
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
                              decoration: const InputDecoration(label: Text('Terminal Konfiguration')),
                              dropdownColor: Colors.blueGrey,
                            ),
                          if (state.selectedConfig != null)
                            TextFormField(
                              initialValue: state.selectedApiKey,
                              decoration: const InputDecoration(label: Text('Api Key')),
                              onChanged: (value) {
                                context.read<ServerConnectionCubit>().selectApiKey(value);
                              },
                              validator: (value) {
                                if ((value ?? '').isEmpty) return 'Pflichtfeld';
                                return null;
                              },
                              obscureText: true,
                            ),
                          if (state.selectedConfig != null && TerminalType.singleuser == state.selectedConfig!.terminaltype)
                            TextFormField(
                                initialValue: state.selectedPilotId,
                                decoration: const InputDecoration(label: Text('Pilot-ID')),
                                onChanged: (value) {
                                  context.read<ServerConnectionCubit>().selectPilotid(value);
                                },
                                validator: (value) {
                                  if ((value ?? '').isEmpty) return 'Pflichtfeld';
                                  return null;
                                }),
                        ],
                      ),
                    ),
                  ),
                  if (state.selectedConfig != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ServerConnectionCubit>().submit();
                          }
                        },
                        label: const Text('Prüfen und speichern'),
                        icon: const Icon(Icons.save),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
