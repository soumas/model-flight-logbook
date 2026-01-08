import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/domain/entities/terminal_config.dart';
import 'package:mfl_terminal/domain/entities/terminal_endpoint.dart';
import 'package:mfl_terminal/mappable.dart';

part 'server_connection_state.mapper.dart';

@mappableStateClass
class ServerConnectionState with ServerConnectionStateMappable {
  final String selectedApiEndpoint;
  final String selectedApiKey;
  final String selectedPilotId;
  final TerminalConfig? selectedConfig;
  final List<TerminalConfig> configOptions;
  final TerminalEndpoint? result;
  final bool loading;
  final dynamic error;
  ServerConnectionState({
    this.selectedApiEndpoint = '',
    this.selectedApiKey = '',
    this.selectedPilotId = '',
    this.selectedConfig,
    this.loading = false,
    this.configOptions = const [],
    this.result,
    this.error,
  });
}
