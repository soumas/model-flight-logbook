import 'package:model_flight_logbook/domain/entities/pilot_status.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';

abstract class LogbookApiRepo {
  Future<List<TerminalConfig>> loadTerminalConfigs({required String apiEndpoint});
  Future<void> checkTerminalConnection({required String apiEndpoint, required String terminalid, required String apiKey, String? pilotid});
  Future<PilotStatus> loadPilotStatus({required TerminalEndpoint endpoint, required String pilotid});
  Future<void> startFlightSession({required TerminalEndpoint endpoint, required String pilotid});
  Future<void> endFlightSession({required TerminalEndpoint endpoint, required String pilotid});
}
