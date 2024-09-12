import 'package:model_flight_logbook/domain/entities/flight_session_status.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';

abstract class LogbookApiRepo {
  Future<List<TerminalConfig>> loadTerminalConfigs({required String apiEndpoint});
  Future<void> checkTerminalConnection({required String apiEndpoint, required String terminalid, required String apiKey, String? pilotid});
  Future<FlightSessionStatus> getFlightSessionStatus({required String pilotid});
  Future<void> startFlightSession({required String pilotid});
  Future<void> endFlightSession({required String pilotid});
}
