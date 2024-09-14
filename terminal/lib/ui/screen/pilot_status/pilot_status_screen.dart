import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PilotStatusScreen extends StatelessWidget {
  const PilotStatusScreen({super.key});

  static const route = '/pilotstate';

  @override
  Widget build(BuildContext context) {
    final pilotid = ModalRoute.of(context)!.settings.arguments!.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sitzungsstatus'),
      ),
      body: BlocProvider<PilotStatusCubit>(
        create: (context) => injector.get<PilotStatusCubit>()..load(pilotid),
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
                    const Text('Pilot-ID: '),
                    Text(state.pilotid),
                  ],
                ),
                Row(
                  children: [
                    const Text('Name: '),
                    Text(state.flightSessionStatus?.pilotName ?? ''),
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
                    Text(state.error.toString()),
                  ],
                ),
                Row(
                  children: [
                    const Text('Loading: '),
                    Text(state.loading.toString()),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: () => context.read<PilotStatusCubit>().load(state.pilotid), child: const Text('Akualisieren')),
                    if (state.flightSessionStatus?.sessionId == null) ElevatedButton(onPressed: () => context.read<PilotStatusCubit>().startSession(), child: const Text('Session starten')),
                    if (state.flightSessionStatus?.sessionId != null) ElevatedButton(onPressed: () => context.read<PilotStatusCubit>().endSession(), child: const Text('Session beenden')),
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
