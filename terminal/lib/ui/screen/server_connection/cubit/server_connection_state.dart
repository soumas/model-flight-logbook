import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'server_connection_state.mapper.dart';

@mappableStateClass
class ServerConnectionState with ServerConnectionStateMappable {
  final bool loading;
  final String apiEndpoint;
  final String apiKey;
  final List<TerminalConfig> configOptions;
  final TerminalEndpoint? result;
  final dynamic error;
  ServerConnectionState({
    this.loading = false,
    this.apiEndpoint = '',
    this.apiKey = '',
    this.configOptions = const [],
    this.result,
    this.error,
  });
}
