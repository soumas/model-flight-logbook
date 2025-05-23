import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:model_flight_logbook/ui/screen/dashboard/cubit/dashboard_cubit.dart';
import 'package:model_flight_logbook/ui/utils/mfl_theme.dart';

class TerminalInfoWidget extends StatelessWidget {
  const TerminalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardCubit>().state;
    return Column(
      children: [
        Text(state.selectedEndpoint?.config.airportname ?? '', style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1), textAlign: TextAlign.center),
        Text(state.selectedEndpoint?.config.terminalname ?? '', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kColorFontSub), textAlign: TextAlign.center),
        if (state.terminalStatus?.operatinghourStart != null)
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text('Betriebszeit:  ${DateFormat.Hm().format(state.terminalStatus!.operatinghourStart!)} - ${DateFormat.Hm().format(state.terminalStatus!.operatinghourEnd!)}'),
          ),
      ],
    );
  }
}
