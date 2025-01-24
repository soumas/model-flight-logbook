import 'dart:async';

import 'package:intl/intl.dart';
import 'package:model_flight_logbook/injector.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/fragments/end_flight_session_button.dart';
import 'package:model_flight_logbook/ui/utils/mfl_paddings.dart';
import 'package:model_flight_logbook/ui/utils/toast.dart';
import 'package:model_flight_logbook/ui/widgets/mfl_message.dart';
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
          Toast.info(context: context, message: 'Checkin / Checkout wurde abgebrochen');
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
          return MflScaffold(
            title: 'Checkin / Checkout',
            child: Builder(
              builder: (context) {
                if (state.loading) {
                  return Center(
                    child: Column(
                      children: [
                        MflPaddings.verticalLarge(context),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else {
                  final errorMessages = [...state.errorMessages ?? [], ...state.flightSessionStatus?.errorMessages ?? []];
                  final warnMessages = [...state.warnMessages ?? [], ...state.flightSessionStatus?.warnMessages ?? []];
                  final infoMessages = [...state.infoMessages ?? [], ...state.flightSessionStatus?.infoMessages ?? []];
                  final anymessage = errorMessages.isNotEmpty || warnMessages.isNotEmpty || infoMessages.isNotEmpty;
                  return Center(
                    child: Column(
                      children: [
                        anymessage ? MflPaddings.verticalSmall(context) : MflPaddings.verticalLarge(context),
                        Text(state.flightSessionStatus?.pilotName ?? '', style: Theme.of(context).textTheme.headlineLarge),
                        _activeSessionInfo(context, state),
                        anymessage ? MflPaddings.verticalSmall(context) : MflPaddings.verticalLarge(context),
                        ...errorMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.error)),
                        ...warnMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.warn)),
                        ...infoMessages.map((e) => MflMessage(text: e, severity: MflMessageSeverity.info)),
                        anymessage ? MflPaddings.verticalMedium(context) : const SizedBox(),
                        if (state.flightSessionStatus?.sessionId != null && state.flightSessionStatus!.sessionStarttime != null) ...const [EndFlightSessionButton()],
                        if (state.flightSessionStatus?.sessionId == null) _startSessionForm(context, state, errorMessages),
                        MflPaddings.verticalLarge(context),
                      ],
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  void _showActionCompletedInfo(BuildContext context, PilotStatusState state) {
    Toast.success(context: context, message: state.completedAction!);
  }

  Widget _activeSessionInfo(BuildContext context, PilotStatusState state) {
    if (state.flightSessionStatus?.sessionId != null && state.flightSessionStatus!.sessionStarttime != null) {
      return Text(
        'Flugtag aktiv seit ${DateFormat.Hm().format(state.flightSessionStatus!.sessionStarttime!)} Uhr',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    } else if (state.flightSessionStatus != null) {
      return Text(
        'Kein aktiver Flugtag',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }
    return const SizedBox();
  }

  Widget _startSessionForm(BuildContext context, PilotStatusState state, List errorMessages) {
    if (state.flightSessionStatus != null) {
      return ElevatedButton.icon(
        onPressed: errorMessages.isEmpty ? () => context.read<PilotStatusCubit>().startSession() : null,
        icon: const Icon(Icons.flight_takeoff),
        label: const Text('Flugtag beginnen'),
      );
    }
    return const SizedBox();
  }
}
