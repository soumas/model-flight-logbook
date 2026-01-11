import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfl_terminal/ui/screen/dashboard/cubit/dashboard_cubit.dart';
import 'package:mfl_terminal/ui/utils/mfl_theme.dart';

class TerminalInfoWidget extends StatelessWidget {
  const TerminalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardCubit>().state;
    return Column(
      children: [
        Text(state.selectedEndpoint?.config.airportname ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.3), textAlign: TextAlign.center),
        Text(state.selectedEndpoint?.config.terminalname ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kColorFontSub), textAlign: TextAlign.center),
        if (state.terminalStatus?.operatinghourStart != null) ...[
          const SizedBox(height: 30.0),
          Text('Betriebszeit', style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.3), textAlign: TextAlign.center),
          Text(
            '${DateFormat.Hm().format(state.terminalStatus!.operatinghourStart!)} Uhr - ${DateFormat.Hm().format(state.terminalStatus!.operatinghourEnd!)} Uhr',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kColorFontSub),
            textAlign: TextAlign.center,
          ),
        ]
      ],
    );
  }
}
