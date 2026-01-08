import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/entities/flight_session.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'flight_session_list_state.mapper.dart';

@mappableStateClass
final class FlightSessionListState with FlightSessionListStateMappable {
  final bool loading;
  final List<FlightSession> flightSessions;
  FlightSessionListState({
    this.loading = false,
    this.flightSessions = const [],
  });
}
