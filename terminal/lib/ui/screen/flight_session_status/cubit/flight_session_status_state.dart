import 'package:dart_mappable/dart_mappable.dart';
import 'package:dronedpace_logbook_terminal/domain/entities/flight_session_status.dart';
import 'package:dronedpace_logbook_terminal/mappable.dart';

part 'flight_session_status_state.mapper.dart';

@mappableStateClass
final class FlightSessionStatusState with FlightSessionStatusStateMappable {
  final bool loading;
  final String pilotid;
  final FlightSessionStatus? flightSessionStatus;
  final dynamic error;
  FlightSessionStatusState({
    this.loading = false,
    this.pilotid = '',
    this.flightSessionStatus,
    this.error,
  });
}
