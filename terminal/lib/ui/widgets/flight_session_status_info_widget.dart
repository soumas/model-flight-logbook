import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mfl_terminal/domain/entities/pilot_status.dart';
import 'package:mfl_terminal/ui/utils/mfl_paddings.dart';

class FlightSessionStatusInfoWidget extends StatelessWidget {
  const FlightSessionStatusInfoWidget({
    super.key,
    required this.pilotStatus,
  });

  final PilotStatus? pilotStatus;

  @override
  Widget build(BuildContext context) {
    final pilotKnown = pilotStatus?.pilotName.isNotEmpty ?? false;
    final hasActiveSession = pilotStatus?.isActiveSession ?? false;
    return pilotStatus != null && pilotKnown
        ? Column(
            children: [
              Text(
                pilotStatus?.pilotName ?? '',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 26, height: 1, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MflPaddings.verticalSmallSize(context)),
              Text(hasActiveSession ? 'Anwesend seit ${DateFormat.Hm().format(pilotStatus!.sessionStarttime!)} Uhr' : 'Nicht anwesend'),
              SizedBox(height: MflPaddings.verticalLargeSize(context) * 1.5),
            ],
          )
        : const SizedBox.shrink();
  }
}
