import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:model_flight_logbook/domain/enums/flight_plan_status.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/ui/utils/mfl_keyboard_layouts.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_message.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class PilotStatusScreen extends StatefulWidget {
  const PilotStatusScreen({super.key});

  static const route = '/pilotstate';

  @override
  State<PilotStatusScreen> createState() => _PilotStatusScreenState();
}

class _PilotStatusScreenState extends State<PilotStatusScreen> {
  final _formKey = GlobalKey<FormState>();
  final _commentTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pilotid = (ModalRoute.of(context)!.settings.arguments ?? 'UNDEFINED_PILOT_ID').toString();
    final localizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => injector.get<PilotStatusCubit>()..init(localizations, pilotid),
      child: MflScaffold(
        alignment: Alignment.center,
        child: BlocConsumer<PilotStatusCubit, PilotStatusState>(
          listener: (context, state) {
            if (context.mounted && state.completedAction != null) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Aktion abgeschlossen'),
                    content: const Text(
                      'A dialog is a type of modal window that\n'
                      'appears in front of app content to\n'
                      'provide critical information, or prompt\n'
                      'for a decision to be made.',
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Schließen'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          builder: (context, state) {
            final errorMessages = [...state.errorMessages ?? [], ...state.flightSessionStatus?.errorMessages ?? []];
            final warnMessages = [...state.warnMessages ?? [], ...state.flightSessionStatus?.warnMessages ?? []];
            final infoMessages = [...state.infoMessages ?? [], ...state.flightSessionStatus?.infoMessages ?? []];
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (state.flightSessionStatus?.pilotName != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Flexible(
                          child: Text(
                            'Pilot: ${state.flightSessionStatus?.pilotName ?? ''}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                    if (state.flightSessionStatus?.sessionId != null && state.flightSessionStatus!.sessionStarttime != null)
                      Text(
                        'Flugtag begonnen: ${DateFormat.yMd().format(state.flightSessionStatus!.sessionStarttime!)}, ${DateFormat.Hm().format(state.flightSessionStatus!.sessionStarttime!)} Uhr',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    if (state.flightSessionStatus?.sessionId != null && state.flightSessionStatus!.sessionEndtime != null)
                      Text(
                        'Flugtag beendet: ${DateFormat.yMd().format(state.flightSessionStatus!.sessionEndtime!)}, ${DateFormat.Hm().format(state.flightSessionStatus!.sessionEndtime!)} Uhr',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    if (state.flightSessionStatus?.sessionId != null && state.flightSessionStatus!.sessionStarttime != null)
                      Text(
                        'UTM Status: ${state.flightSessionStatus!.flightPlanStatus!.toLabel(AppLocalizations.of(context)!)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    if (state.flightSessionStatus?.sessionId != null && state.flightSessionStatus!.sessionStarttime != null)
                      const SizedBox(
                        height: 20,
                      ),
                    ...errorMessages.map(
                      (e) => MflMessage(
                        text: e,
                        severity: MflMessageSeverity.error,
                      ),
                    ),
                    ...warnMessages.map(
                      (e) => MflMessage(
                        text: e,
                        severity: MflMessageSeverity.warn,
                      ),
                    ),
                    ...infoMessages.map(
                      (e) => MflMessage(
                        text: e,
                        severity: MflMessageSeverity.info,
                      ),
                    ),
                    ..._startSessionForm(context, state, errorMessages),
                    ..._endSessionForm(context, state, errorMessages),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () => context.read<PilotStatusCubit>().init(localizations, pilotid),
                            label: const Text('Aktualisieren'),
                            icon: const Icon(Icons.refresh),
                          ),
                          TextButton.icon(
                            onPressed: () => Navigator.of(context).pop(),
                            label: const Text('Abbrechen'),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> _startSessionForm(BuildContext context, PilotStatusState state, errorMessages) {
    if (errorMessages.isEmpty && state.flightSessionStatus?.sessionId == null) {
      return [
        const MflMessage(
          text:
              'Wenn du fortfährst akzeptierst du die Bedingungen des UTM Systems (https://utm.dronespace.at/avm/?#p=7.24/47.501/13.733) und bist damit einverstanden, dass zum Zwecke der gesetzlich erforderlichen Meldung deine Daten (Name, E-Mail, Telefonnummer) an die Luftfahrtbehörde übermittelt werden.',
          icon: SizedBox(),
        ),
        CheckboxListTile(
          value: state.termsAccepted,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (value) {
            context.read<PilotStatusCubit>().toggleTermsAccepted();
          },
          title: Text(
            'Ich akzeptiere die genannten Bedingungen',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        ElevatedButton.icon(
          onPressed: state.termsAccepted ? () => context.read<PilotStatusCubit>().startSession() : null,
          label: const Text('Flugtag beginnen'),
          icon: const Icon(Icons.flight_takeoff),
        ),
      ];
    }
    return [];
  }

  _endSessionForm(BuildContext context, PilotStatusState state, errorMessages) {
    if (state.flightSessionStatus?.sessionId != null && state.flightSessionStatus!.sessionStarttime != null) {
      return [
        if (FlightPlanStatus.flying == state.flightSessionStatus?.flightPlanStatus!)
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(label: Text('Anzahl Flüge')),
            onChanged: (value) => context.read<PilotStatusCubit>().setNumFlights(int.parse(value)),
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (state.numFlights == null) {
                return 'Dieses Feld darf nicht leer bleiben';
              }
              return null;
            },
          ),
        if (FlightPlanStatus.flying == state.flightSessionStatus?.flightPlanStatus!)
          TextFormField(
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Besondere Ereignisse'),
            //onChanged: (value) => context.read<PilotStatusCubit>().setComment(value),
            controller: _commentTextEditingController,
            onTap: () {
              showModalBottomSheet(
                constraints: BoxConstraints.expand(height: 200, width: 460),
                context: context,
                builder: (context) {
                  return Container(
                    height: 200,
                    color: Colors.deepPurple,
                    child: VirtualKeyboard(
                      height: 180,
                      width: 460,
                      textColor: Colors.white,
                      textController: _commentTextEditingController,
                      type: VirtualKeyboardType.Alphanumeric,
                      customLayoutKeys: MflKeyboardLayouts(),
                    ),
                  );
                },
              );
            },
          ),
        if (FlightPlanStatus.flying == state.flightSessionStatus?.flightPlanStatus!)
          const SizedBox(
            height: 20,
          ),
        if (FlightPlanStatus.flying == state.flightSessionStatus?.flightPlanStatus!)
          ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<PilotStatusCubit>().endSession();
              }
            },
            label: const Text('Flugtag beenden'),
            icon: const Icon(Icons.flight_land),
          ),
      ];
    }
    return [];
  }
}
