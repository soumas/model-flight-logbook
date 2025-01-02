import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/end_flight_session_data.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/fragments/end_flight_session_form.dart';

class EndFlightSessionButton extends StatelessWidget {
  const EndFlightSessionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final data = (await Navigator.of(context).pushNamed(EndFlightSessionForm.route)) as EndFlightSessionData?;
        if (data != null && context.mounted) {
          context.read<PilotStatusCubit>().endSession(data: data);
        }
      },
      icon: const Icon(Icons.flight_land_rounded),
      label: const Text('Flugtag beenden'),
    );
  }
}
