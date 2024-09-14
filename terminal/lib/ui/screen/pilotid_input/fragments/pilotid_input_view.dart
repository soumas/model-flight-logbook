import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_cubit.dart';

class PilotidInputView extends StatelessWidget {
  const PilotidInputView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PilotidInputCubit>().state;
    if (state.selectedEndpoint == null) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Model Flight Logbook Terminal',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          'Fügen Sie über die Einstellungen eine Serververbindung hinzu.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ]);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.selectedEndpoint?.config.airportname ?? 'Unbekannter Flugplatz',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            state.selectedEndpoint?.config.terminalname ?? 'Unbekanntes Terminal',
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.selectedEndpoint!.config.terminaltype == 'multiuser')
                    Image.asset(
                      kAssetRfidIconSlim,
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                  if (state.selectedEndpoint!.config.terminaltype == 'singleuser')
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(PilotStatusScreen.route, arguments: state.selectedEndpoint!.pilotid ?? 'unbekannt');
                      },
                      child: Text('Status prüfen\nPilot: ${state.selectedEndpoint!.pilotid ?? 'unbekannt'}'),
                    )
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
