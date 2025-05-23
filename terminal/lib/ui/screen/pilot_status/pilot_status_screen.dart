import 'dart:async';

import 'package:model_flight_logbook/domain/entities/end_flight_session_data.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/fragments/end_flight_session_form.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/fragments/pilot_messages_view.dart';
import 'package:model_flight_logbook/ui/utils/mfl_paddings.dart';
import 'package:model_flight_logbook/ui/utils/mfl_theme.dart';
import 'package:model_flight_logbook/ui/utils/toast.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';

class PilotStatusScreen extends StatefulWidget {
  const PilotStatusScreen({super.key});

  static const route = '/pilotstate';

  @override
  State<PilotStatusScreen> createState() => _PilotStatusScreenState();
}

class _PilotStatusScreenState extends State<PilotStatusScreen> {
  Timer? _autoCloseTimer;

  @override
  void initState() {
    super.initState();
    _initAutoCloseTimer();
  }

  @override
  void dispose() {
    _disposeAutoCloseTimer();
    super.dispose();
  }

  void _initAutoCloseTimer() {
    _disposeAutoCloseTimer();
    _autoCloseTimer = Timer(
      const Duration(seconds: 15),
      () {
        if (!context.mounted) return;
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          Navigator.of(context).pop();
        } else {
          _initAutoCloseTimer();
        }
      },
    );
  }

  void _disposeAutoCloseTimer() {
    if (_autoCloseTimer != null) {
      _autoCloseTimer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pilotid = (ModalRoute.of(context)!.settings.arguments ?? 'UNKNOWN_PILOT').toString();
    final localizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => injector.get<PilotStatusCubit>()..init(localizations, pilotid),
      child: BlocConsumer<PilotStatusCubit, PilotStatusState>(
        listener: (context, state) async {
          if (context.mounted && state.completedAction != null) {
            _showActionCompletedInfo(context, state);
            if (context.mounted) {
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          }
        },
        builder: (context, state) {
          final hasActiveSession = state.flightSessionStatus?.sessionId != null && state.flightSessionStatus!.sessionStarttime != null;
          return MflScaffold(
            title: 'Status Pilot:in',
            showBackgroundImage: true,
            child1: const PilotMessagesView(),
            child2: Column(
              children: [
                Text(
                  state.flightSessionStatus?.pilotName ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 26, height: 1, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MflPaddings.verticalSmallSize(context)),
                Card(
                  color: hasActiveSession ? kColorSuccess : kColorWarning,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    child: Text(hasActiveSession ? 'anwesend' : 'abwesend'),
                  ),
                ),
                SizedBox(height: MflPaddings.verticalLargeSize(context)),
                if (!hasActiveSession)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: (state.flightSessionStatus?.errorMessages ?? []).isEmpty ? () => context.read<PilotStatusCubit>().startSession() : null,
                      label: const Text('Kommen'),
                      icon: const Icon(Icons.login),
                    ),
                  ),
                if (hasActiveSession)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final data = (await Navigator.of(context).pushNamed(EndFlightSessionForm.route, arguments: state)) as EndFlightSessionData?;
                        if (data != null && context.mounted) {
                          context.read<PilotStatusCubit>().endSession(data: data);
                        }
                      },
                      label: const Text('Gehen'),
                      icon: const Icon(Icons.logout),
                    ),
                  ),
                // SizedBox(height: MflPaddings.verticalMediumSize(context)),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //     label: const Text('Schließen'),
                //     icon: const Icon(Icons.close),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showActionCompletedInfo(BuildContext context, PilotStatusState state) {
    Toast.success(context: context, message: state.completedAction!);
  }
}
