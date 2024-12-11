import 'package:intl/intl.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/domain/enums/flight_plan_status.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/fragments/end_flight_session_button.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_message.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';

class PilotStatusScreen extends StatelessWidget {
  const PilotStatusScreen({super.key});

  static const route = '/pilotstate';

  @override
  Widget build(BuildContext context) {
    final pilotid = (ModalRoute.of(context)!.settings.arguments ?? 'UNDEFINED_PILOT_ID').toString();
    final localizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => injector.get<PilotStatusCubit>()..init(localizations, pilotid),
      child: MflScaffold(
        alignment: Alignment.center,
        child: BlocConsumer<PilotStatusCubit, PilotStatusState>(
          listener: (context, state) async {
            if (context.mounted && state.completedAction != null) {
              await _showActionCompletedInfo(context, state);
              if (context.mounted) {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            }
          },
          builder: (context, state) {
            final errorMessages = [...state.errorMessages ?? [], ...state.flightSessionStatus?.errorMessages ?? []];
            final warnMessages = [...state.warnMessages ?? [], ...state.flightSessionStatus?.warnMessages ?? []];
            final infoMessages = [...state.infoMessages ?? [], ...state.flightSessionStatus?.infoMessages ?? []];
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  if (state.flightSessionStatus?.pilotName != null)
                    Padding(
                      padding: kFormFieldPadding,
                      child: Container(
                        child: Text(
                          'Pilot: ${state.flightSessionStatus?.pilotName ?? ''}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  if (state.flightSessionStatus?.sessionId != null && state.flightSessionStatus!.sessionStarttime != null) ..._activeSessionInfo(context, state),
                  ...errorMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.error)),
                  ...warnMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.warn)),
                  ...infoMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.info)),
                  if (errorMessages.isEmpty && state.flightSessionStatus?.sessionId == null) ..._startSessionForm(context, state, errorMessages),
                  if (FlightPlanStatus.flying == state.flightSessionStatus?.flightPlanStatus || FlightPlanStatus.error == state.flightSessionStatus?.flightPlanStatus) EndFlightSessionButton(),
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
              );
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> _showActionCompletedInfo(BuildContext context, PilotStatusState state) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          content: Text('"${state.completedAction}" wurde ausgeführt'),
          contentTextStyle: Theme.of(context).textTheme.titleLarge,
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Schließen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> _activeSessionInfo(BuildContext context, PilotStatusState state) {
    return [
      Text(
        'Flugtag begonnen: ${DateFormat.yMd().format(state.flightSessionStatus!.sessionStarttime!)}, ${DateFormat.Hm().format(state.flightSessionStatus!.sessionStarttime!)} Uhr',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      if (state.flightSessionStatus!.sessionEndtime != null)
        Text(
          'Flugtag beendet: ${DateFormat.yMd().format(state.flightSessionStatus!.sessionEndtime!)}, ${DateFormat.Hm().format(state.flightSessionStatus!.sessionEndtime!)} Uhr',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      if (state.flightSessionStatus!.flightPlanStatus != null)
        Text(
          'UTM Status: ${state.flightSessionStatus!.flightPlanStatus!.toLabel(AppLocalizations.of(context)!)}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      const SizedBox(
        height: 20,
      ),
    ];
  }

  List<Widget> _startSessionForm(BuildContext context, PilotStatusState state, errorMessages) {
    return [
      const MflMessage(
        severity: MflMessageSeverity.info,
        text: 'Deine Daten (Name, E-Mail, Telefonnummer) werden zwecks der gesetzlich erforderlichen Meldung an die Luftfahrtbehörde übermittelt. Außerdem akzeptierst du die Bedingungen des UTM Systems unter https://utm.dronespace.at/avm/.',
        icon: SizedBox(),
      ),
      CheckboxListTile(
        value: state.termsAccepted,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (value) {
          context.read<PilotStatusCubit>().toggleTermsAccepted();
        },
        title: Text(
          'Ja, ich bin damit einverstanden',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.left,
        ),
      ),
      ElevatedButton.icon(
        onPressed: state.termsAccepted ? () => context.read<PilotStatusCubit>().startSession() : null,
        label: const Text('Flugtag beginnen'),
        icon: const Icon(Icons.flight_takeoff),
      ),
    ];
  }
}
