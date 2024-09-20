import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/entities/pilot_status.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'pilot_status_state.mapper.dart';

@mappableStateClass
final class PilotStatusState with PilotStatusStateMappable {
  final bool loading;
  final String pilotid;
  final PilotStatus? flightSessionStatus;
  final String? completedAction;
  final List<String>? infoMessages;
  final List<String>? warnMessages;
  final List<String>? errorMessages;
  final bool termsAccepted;
  final int? numFlights;
  final String? comment;
  PilotStatusState({
    this.loading = false,
    this.pilotid = '',
    this.flightSessionStatus,
    this.completedAction,
    this.infoMessages,
    this.warnMessages,
    this.errorMessages,
    this.termsAccepted = false,
    this.numFlights,
    this.comment,
  });
}
