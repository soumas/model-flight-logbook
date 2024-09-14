import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/entities/pilot_status.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'pilot_status_state.mapper.dart';

@mappableStateClass
final class PilotStatusState with PilotStatusStateMappable {
  final bool loading;
  final String pilotid;
  final PilotStatus? flightSessionStatus;
  final dynamic error;
  final String? completedAction;
  PilotStatusState({
    this.loading = false,
    this.pilotid = '',
    this.flightSessionStatus,
    this.error,
    this.completedAction,
  });
}
