import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/enums/terminal_type.dart';
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MflPaddings.verticalLarge(context),
          Text(
            state.selectedEndpoint?.config.airportname ?? 'Unbekannter Flugplatz',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            state.selectedEndpoint?.config.terminalname ?? 'Unbekanntes Terminal',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          MflPaddings.verticalLarge(context),
          if (state.terminalStatus != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('UTM-Status:'),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 4.0),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
                Text(state.terminalStatus!.utmStatus),
              ],
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
