import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/constants.dart';
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
  final _apiKeyController = TextEditingController();
  final _pilotIdController = TextEditingController();

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
                  MflTextFormField(
                    controller: _serverUrlController,
                    label: 'Server URL',
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
                    onClose: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ServerConnectionCubit>().loadConfigurations(_serverUrlController.text);
                      }
                    },
                  ),
                  if (state.configOptions.isNotEmpty)
                    DropdownButtonFormField(
                      padding: kFormFieldPadding,
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
                    MflTextFormField(
                      controller: _apiKeyController,
                      label: 'Api Key',
                      onClose: () {
                        context.read<ServerConnectionCubit>().selectApiKey(_apiKeyController.text);
                      },
                      validator: (value) {
                        if ((value ?? '').isEmpty) return 'Pflichtfeld';
                        return null;
                      },
                      obscureText: true,
                    ),
                  if (state.selectedConfig != null && TerminalType.singleuser == state.selectedConfig!.terminaltype)
                    MflTextFormField(
                        controller: _pilotIdController,
                        label: 'Pilot-ID',
                        onClose: () {
                          context.read<ServerConnectionCubit>().selectPilotid(_pilotIdController.text);
                        },
                        validator: (value) {
                          if ((value ?? '').isEmpty) return 'Pflichtfeld';
                          return null;
                        }),
                  if (state.error != null)
                    Padding(
                      padding: kFormFieldPadding,
                      child: MflMessage(
                        text: state.error.toString(),
                        severity: MflMessageSeverity.error,
                      ),
                    ),
                  if (state.selectedConfig != null)
                    Padding(
                      padding: kFormFieldPadding,
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
