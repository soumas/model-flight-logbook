import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:model_flight_logbook/ui/widgets/messages_column.dart';

class PilotMessagesView extends StatelessWidget {
  const PilotMessagesView({
    super.key,
    this.onWarnMessageAcceptedChanged,
  });

  final Function(String message, bool accepted)? onWarnMessageAcceptedChanged;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PilotStatusCubit>().state;
    return MessagesColumn(
      errorMessages: state.flightSessionStatus?.errorMessages ?? [],
      warnMessages: state.flightSessionStatus?.warnMessages ?? [],
      infoMessages: state.flightSessionStatus?.infoMessages ?? [],
      onWarnMessageAcceptedChanged: onWarnMessageAcceptedChanged,
    );
  }
}
