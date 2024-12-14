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
import 'package:model_flight_logbook/ui/utils/toast.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_message.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';

class PilotStatusScreen extends StatelessWidget {
  const PilotStatusScreen({super.key});

  static const route = '/pilotstate';

  @override
  Widget build(BuildContext context) {
    final pilotid = (ModalRoute.of(context)!.settings.arguments ?? '0012833868').toString();
    final localizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => injector.get<PilotStatusCubit>()..init(localizations, pilotid),
      child: MflScaffold(
        alignment: Alignment.center,
        child: BlocConsumer<PilotStatusCubit, PilotStatusState>(
          listener: (context, state) async {
            if (context.mounted && state.completedAction != null) {
              _showActionCompletedInfo(context, state);
              if (context.mounted) {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            }
          },
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final errorMessages = [...state.errorMessages ?? [], ...state.flightSessionStatus?.errorMessages ?? []];
              final warnMessages = [...state.warnMessages ?? [], ...state.flightSessionStatus?.warnMessages ?? []];
              final infoMessages = [...state.infoMessages ?? [], ...state.flightSessionStatus?.infoMessages ?? []];
              return Column(
                children: [
                  if (state.flightSessionStatus?.pilotName != null)
                    Padding(
                      padding: kFormFieldPadding,
                      child: Text(state.flightSessionStatus?.pilotName ?? '', style: Theme.of(context).textTheme.headlineLarge),
                    ),
                  ...errorMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.error)),
                  ...warnMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.warn)),
                  ...infoMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.info)),
                  if (state.flightSessionStatus?.sessionId != null && state.flightSessionStatus!.sessionStarttime != null) ..._activeSessionInfo(context, state),
                  if (errorMessages.isEmpty && state.flightSessionStatus?.sessionId == null) ..._startSessionForm(context, state, errorMessages),
                  if (FlightPlanStatus.flying == state.flightSessionStatus?.flightPlanStatus || FlightPlanStatus.error == state.flightSessionStatus?.flightPlanStatus || FlightPlanStatus.featureDisabled == state.flightSessionStatus?.flightPlanStatus) EndFlightSessionButton(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _showActionCompletedInfo(BuildContext context, PilotStatusState state) {
    Toast.success(context: context, message: '${state.completedAction} OK');
  }

  List<Widget> _activeSessionInfo(BuildContext context, PilotStatusState state) {
    return [
      Text(
        'Aktiv seit ${DateFormat.yMd().format(state.flightSessionStatus!.sessionStarttime!)}, ${DateFormat.Hm().format(state.flightSessionStatus!.sessionStarttime!)} Uhr',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      if (state.flightSessionStatus!.sessionEndtime != null)
        Text(
          'Sitzung beendet: ${DateFormat.yMd().format(state.flightSessionStatus!.sessionEndtime!)}, ${DateFormat.Hm().format(state.flightSessionStatus!.sessionEndtime!)} Uhr',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      if (state.flightSessionStatus!.flightPlanStatus != null && state.flightSessionStatus!.flightPlanStatus != FlightPlanStatus.featureDisabled)
        Text(
          'UTM Status: ${state.flightSessionStatus!.flightPlanStatus!.toLabel(AppLocalizations.of(context)!)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      const SizedBox(
        height: 20,
      ),
    ];
  }

  List<Widget> _startSessionForm(BuildContext context, PilotStatusState state, errorMessages) {
    return [
      Text(
        'Status: Keine aktive Sitzung',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(
        height: 70,
      ),
      InkWell(
        onTap: () => context.read<PilotStatusCubit>().toggleTermsAccepted(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Transform.scale(
                scale: 1.8,
                child: Checkbox(
                  value: state.termsAccepted,
                  onChanged: (_) {},
                ),
              ),
            ),
            const Text('Nutzungsbedingungen akzeptieren\nhttps://www.msgu.at/mfl'),
          ],
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      ElevatedButton.icon(
        onPressed: state.termsAccepted ? () => context.read<PilotStatusCubit>().startSession() : null,
        label: const Text('Sitzung beginnen'),
        icon: const Icon(Icons.flight_takeoff),
      ),
    ];
  }
}
