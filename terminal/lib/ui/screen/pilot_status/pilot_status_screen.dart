import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';

class PilotStatusScreen extends StatelessWidget {
  const PilotStatusScreen({super.key});

  static const route = '/pilotstate';

  @override
  Widget build(BuildContext context) {
    final pilotid = (ModalRoute.of(context)!.settings.arguments ?? 'NO_PILOT_ID_PROVIDED').toString();
    return BlocProvider(
      create: (context) => injector.get<PilotStatusCubit>()..load(pilotid),
      child: MflScaffold(
        title: 'Pilotenstatus',
        alignment: Alignment.center,
        child: BlocConsumer<PilotStatusCubit, PilotStatusState>(
          listener: (context, state) {
            if (state.completedAction != null) {
              Navigator.of(context).pop(state.completedAction);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      state.flightSessionStatus?.pilotName ?? '',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'ID: ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      state.pilotid,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Session Start: '),
                    Text(state.flightSessionStatus?.sessionStarttime ?? ''),
                  ],
                ),
                Row(
                  children: [
                    const Text('Session End: '),
                    Text(state.flightSessionStatus?.sessionEndtime ?? ''),
                  ],
                ),
                Row(
                  children: [
                    const Text('Flightplan Status: '),
                    Text(state.flightSessionStatus?.flightPlanStatus ?? ''),
                  ],
                ),
                Row(
                  children: [
                    const Text('Error: '),
                    Text(state.errorMessages?.toString() ?? 'kein fehler'),
                  ],
                ),
                Row(
                  children: [
                    const Text('Loading: '),
                    Text(state.loading.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.flightSessionStatus?.sessionId == null) ElevatedButton(onPressed: () => context.read<PilotStatusCubit>().startSession(), child: const Text('Flugtag starten')),
                    if (state.flightSessionStatus?.sessionId != null) ElevatedButton(onPressed: () => context.read<PilotStatusCubit>().endSession(), child: const Text('Flugtag beenden')),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
