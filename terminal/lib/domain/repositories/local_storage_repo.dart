import 'package:mfl_terminal/domain/entities/settings.dart';
import 'package:mfl_terminal/domain/entities/terminal_endpoint.dart';

abstract class LocalStorageRepo {
  Future<Settings> loadSettings();
  Future saveSettings(Settings settings);
  Future<TerminalEndpoint?> loadSelectedTerminalEndpoint();
  Future saveSelectedTerminalEndpoint(TerminalEndpoint? endpoint);
}
