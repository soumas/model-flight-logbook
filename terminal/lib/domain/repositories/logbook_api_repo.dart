import 'package:model_flight_logbook_terminal/domain/entities/flight_session_status.dart';

abstract class LogbookApiRepo {
  Future<FlightSessionStatus> getFlightSessionStatus({required String pilotid});
  Future<void> startFlightSession({required String pilotid});
  Future<void> endFlightSession({required String pilotid});
}
