import 'package:model_flight_logbook/domain/entities/settings.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';

abstract class LocalStorageRepo {
  Future<Settings> loadSettings();
  Future saveSettings(Settings settings);
  Future<TerminalEndpoint?> loadSelectedTerminalEndpoint();
  Future saveSelectedTerminalEndpoint(TerminalEndpoint? endpoint);
}
