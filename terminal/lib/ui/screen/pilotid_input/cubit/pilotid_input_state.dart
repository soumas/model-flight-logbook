import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/entities/utm_status.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'pilotid_input_state.mapper.dart';

@mappableStateClass
class PilotidInputState with PilotidInputStateMappable {
  final List<TerminalEndpoint> endpointOptions;
  final TerminalEndpoint? selectedEndpoint;
  final UtmStatus? terminalStatus;
  PilotidInputState({
    this.endpointOptions = const [],
    this.selectedEndpoint,
    this.terminalStatus,
  });
}
