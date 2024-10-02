import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/domain/enums/terminal_type.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_cubit.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_message.dart';

class PilotidInputView extends StatelessWidget {
  const PilotidInputView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PilotidInputCubit>().state;
    if (state.selectedEndpoint == null) {
      return Column(
        children: [
          Image.asset(
            kAssetMflLogoSlim,
            height: 80,
          ),
          Text(
            'Model Flight Logbook',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Text('by SoumaSoft', style: Theme.of(context).textTheme.labelSmall),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: MflMessage(
              severity: MflMessageSeverity.info,
              text: 'Füge über die Einstellungen einen Server hinzu.',
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            state.selectedEndpoint?.config.airportname ?? 'Unbekannter Flugplatz',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            state.selectedEndpoint?.config.terminalname ?? 'Unbekanntes Terminal',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (TerminalType.multiuser == state.selectedEndpoint!.config.terminaltype)
            MflMessage(
              text: state.selectedEndpoint!.config.pilotidinstruction,
              severity: MflMessageSeverity.info,
            ),
          if (TerminalType.singleuser == state.selectedEndpoint!.config.terminaltype)
            ElevatedButton.icon(
              icon: const Icon(Icons.touch_app),
              onPressed: () {
                Navigator.of(context).pushNamed(PilotStatusScreen.route, arguments: state.selectedEndpoint!.pilotid);
              },
              label: const Text('Status anzeigen'),
            ),
          const SizedBox(height: 50),
          Image.asset(
            kAssetMflLogoSlim,
            height: 50,
          ),
          Text('Model Flight Logbook', style: Theme.of(context).textTheme.labelSmall),
        ],
      );
    }
  }
}
