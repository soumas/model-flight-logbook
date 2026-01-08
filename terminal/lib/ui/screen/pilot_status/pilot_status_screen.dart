import 'dart:async';
import 'dart:developer';

import 'package:model_flight_logbook/domain/entities/end_flight_session_data.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/flight_session_list/flight_session_list_screen.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/fragments/end_flight_session_form.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/fragments/pilot_messages_view.dart';
import 'package:model_flight_logbook/ui/utils/mfl_paddings.dart';
import 'package:model_flight_logbook/ui/utils/mfl_theme.dart';
import 'package:model_flight_logbook/ui/utils/toast.dart';
import 'package:model_flight_logbook/ui/widgets/flight_session_status_info_widget.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_scaffold.dart';

class PilotStatusScreen extends StatefulWidget {
  const PilotStatusScreen({super.key, required this.pilotId});

  static const route = '/pilotstate';

  final String pilotId;

  @override
  State<PilotStatusScreen> createState() => _PilotStatusScreenState();
}

class _PilotStatusScreenState extends State<PilotStatusScreen> {
  Timer? _autoCloseTimer;
  final Set<String> _acceptedWarnMessages = {};

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
      const Duration(seconds: 30),
      () {
        if (!context.mounted) return;
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          Navigator.of(context).popUntil((route) => route.isFirst);
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
    final pilotid = widget.pilotId;
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
          final pilotUnknown = state.flightSessionStatus?.pilotName.isEmpty ?? true;
          final hasActiveSession = state.flightSessionStatus?.isActiveSession ?? false;
          final hasErrors = (state.flightSessionStatus?.errorMessages ?? []).isNotEmpty;
          final allWarningsAccepted =
              hasErrors || (state.flightSessionStatus?.warnMessages ?? []).every((msg) => _acceptedWarnMessages.contains(msg));
          return GestureDetector(
            onTapDown: (details) {
              log('GestureDetector');
              _initAutoCloseTimer();
            },
            child: MflScaffold(
              showBackgroundImage: true,
              child1: PilotMessagesView(
                onWarnMessageAcceptedChanged: !hasActiveSession && !hasErrors
                    ? (String message, bool accepted) {
                        if (accepted) {
                          _acceptedWarnMessages.add(message);
                        } else {
                          _acceptedWarnMessages.remove(message);
                        }
                        setState(() {});
                      }
                    : null,
              ),
              child2: Column(
                children: [
                  FlightSessionStatusInfoWidget(pilotStatus: state.flightSessionStatus),
                  if (!hasActiveSession && hasErrors) ...[
                    const Text('Check-In verweigert!', style: TextStyle(color: kColorError, fontWeight: FontWeight.bold)),
                  ],
                  if (!hasActiveSession && !allWarningsAccepted) ...[
                    const Text('Warnungen akzeptieren!', style: TextStyle(color: kColorWarning, fontWeight: FontWeight.bold)),
                  ],
                  if (!hasActiveSession)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: (hasErrors || !allWarningsAccepted) ? null : () => context.read<PilotStatusCubit>().startSession(),
                        label: const Text('Check-In'),
                        icon: const Icon(Icons.login),
                      ),
                    ),
                  if (hasActiveSession)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final data = (await Navigator.of(context).push(
                            PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => EndFlightSessionForm(state: state)),
                          )) as EndFlightSessionData?;
                          if (data != null && context.mounted) {
                            context.read<PilotStatusCubit>().endSession(data: data);
                          }
                        },
                        label: const Text('Check-Out'),
                        icon: const Icon(Icons.logout),
                      ),
                    ),
                  SizedBox(height: MflPaddings.verticalLargeSize(context)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: pilotUnknown
                          ? null
                          : () => Navigator.of(context).push(
                                PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => PilotLogbookScreen(state: state)),
                              ),
                      label: const Text('Flugbuch'),
                      icon: const Icon(Icons.book_outlined),
                    ),
                  ),
                  SizedBox(height: MflPaddings.verticalMediumSize(context)),
                  const Divider(),
                  SizedBox(height: MflPaddings.verticalMediumSize(context)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                      label: const Text('Schließen'),
                    ),
                  ),
                ],
              ),
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
