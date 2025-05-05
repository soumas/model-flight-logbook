import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:model_flight_logbook/domain/enums/terminal_type.dart';
import 'package:model_flight_logbook/domain/enums/utm_sync_status.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_state.dart';
import 'package:model_flight_logbook/ui/utils/mfl_paddings.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_message.dart';

class PilotidInputView extends StatefulWidget {
  const PilotidInputView({
    super.key,
  });

  @override
  State<PilotidInputView> createState() => _PilotidInputViewState();
}

class _PilotidInputViewState extends State<PilotidInputView> {
  late final Timer _refreshTerminalStateTimer;

  @override
  void initState() {
    super.initState();
    _refreshTerminalStateTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) => context.read<PilotidInputCubit>().updateTerminalState(),
    );
  }

  @override
  void dispose() {
    _refreshTerminalStateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PilotidInputCubit>().state;
    return state.selectedEndpoint == null ? const SetupRequired() : SelectedEndpointView(state: state);
  }
}

class SelectedEndpointView extends StatelessWidget {
  const SelectedEndpointView({
    super.key,
    required this.state,
  });

  final PilotidInputState state;

  @override
  Widget build(BuildContext context) {
    final errorMessages = state.terminalStatus?.errorMessages != null ? state.terminalStatus?.errorMessages! : [];
    final warnMessages = state.terminalStatus?.warnMessages != null ? state.terminalStatus?.warnMessages! : [];
    final infoMessages = state.terminalStatus?.infoMessages != null ? state.terminalStatus?.infoMessages! : [];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.selectedEndpoint?.config.airportname ?? 'Unbekannter Flugplatz',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          // Text(
          //   state.selectedEndpoint?.config.terminalname ?? 'Unbekanntes Terminal',
          //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(90)),
          // ),
          if (state.terminalStatus != null && state.terminalStatus!.operatinghourStart != null && state.terminalStatus!.operatinghourEnd != null) MflPaddings.verticalSmall(context),
          if (state.terminalStatus != null && state.terminalStatus!.operatinghourStart != null && state.terminalStatus!.operatinghourEnd != null)
            Text(
              'Betriebszeit:  ${DateFormat.Hm().format(state.terminalStatus!.operatinghourStart!)} Uhr - ${DateFormat.Hm().format(state.terminalStatus!.operatinghourEnd!)} Uhr',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          MflPaddings.verticalMedium(context),
          const Divider(),
          // MflPaddings.verticalMedium(context),
          ...errorMessages!.map((e) => MflMessage(text: e, severity: MflMessageSeverity.error)),
          ...warnMessages!.map((e) => MflMessage(text: e, severity: MflMessageSeverity.warn)),
          ...infoMessages!.map((e) => MflMessage(text: e, severity: MflMessageSeverity.info)),
          MflPaddings.verticalMedium(context),
          if (state.terminalStatus != null && state.terminalStatus!.utmStatus != UtmSyncStatus.disabled)
            GestureDetector(
              onTap: () => context.read<PilotidInputCubit>().updateTerminalState(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    state.terminalStatus?.utmStatus.icon,
                    color: state.terminalStatus?.utmStatus.color,
                    size: 64,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${state.terminalStatus?.utmStatus.label}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: state.terminalStatus?.utmStatus.color, height: 1.1)),
                      Row(
                        children: [
                          Text(
                            'Letztes Update: ${DateFormat.Hm().format(state.terminalStatus!.statusReceiveTime!)} Uhr',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(90)),
                          ),
                          if (state.terminalStatus?.utmBusy ?? false)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(height: 12, width: 12, child: CircularProgressIndicator(strokeWidth: 1, color: Theme.of(context).colorScheme.onSurface.withAlpha(90))),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          MflPaddings.verticalMedium(context),
          if (TerminalType.singleuser == state.selectedEndpoint!.config.terminaltype)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  PilotStatusScreen.route,
                  arguments: state.selectedEndpoint!.pilotid,
                );
              },
              child: const Text('Status anzeigen'),
            ),
          MflPaddings.verticalLarge(context),
        ],
      ),
    );
  }
}

class SetupRequired extends StatelessWidget {
  const SetupRequired({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: MflMessage(
        severity: MflMessageSeverity.info,
        text: 'Model Flight Logbook\nSetup erforderlich',
      ),
    );
  }
}
