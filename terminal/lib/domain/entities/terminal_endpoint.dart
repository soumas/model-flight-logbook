import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'terminal_endpoint.mapper.dart';

@mappableModelClass
class TerminalEndpoint with TerminalEndpointMappable {
  final String apiEndpoint;
  final String apiKey;
  final TerminalConfig config;
  TerminalEndpoint({
    required this.apiEndpoint,
    required this.apiKey,
    required this.config,
  });
}
