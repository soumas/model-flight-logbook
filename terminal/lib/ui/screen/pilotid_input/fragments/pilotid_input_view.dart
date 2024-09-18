import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/pilot_status_screen.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_cubit.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_message_block.dart';

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
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: MflMessageBlock(
              severity: MflCardSeverity.info,
              text: 'Setup erforderlich - fügen Sie einen Server hinzu',
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
          if (state.selectedEndpoint!.config.terminaltype == 'multiuser')
            MflMessageBlock(
              text: state.selectedEndpoint!.config.pilotidinstruction,
              severity: MflCardSeverity.info,
            ),
          if (state.selectedEndpoint!.config.terminaltype == 'singleuser')
            ElevatedButton.icon(
              icon: Icon(Icons.touch_app),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                elevation: 3,
                shadowColor: Colors.white,
                iconColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(PilotStatusScreen.route, arguments: state.selectedEndpoint!.pilotid ?? 'unbekannt');
              },
              label: Text(
                'Pilotenstatus anzeigen',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
              ),
            ),
        ],
      );
    }
  }
}
