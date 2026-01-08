import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/domain/entities/terminal_config.dart';
import 'package:mfl_terminal/mappable.dart';

part 'terminal_endpoint.mapper.dart';

@mappableModelClass
class TerminalEndpoint with TerminalEndpointMappable {
  final String apiEndpoint;
  final String apiKey;
  final String? pilotid;
  final TerminalConfig config;
  TerminalEndpoint({
    required this.apiEndpoint,
    required this.apiKey,
    required this.config,
    this.pilotid,
  });
}
