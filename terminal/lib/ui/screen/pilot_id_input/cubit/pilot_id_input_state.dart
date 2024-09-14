import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'pilot_id_input_state.mapper.dart';

@mappableStateClass
class PilotIdInputState with PilotIdInputStateMappable {
  final List<TerminalEndpoint> endpointOptions;
  final TerminalEndpoint? selectedEndpoint;
  PilotIdInputState({
    this.endpointOptions = const [],
    this.selectedEndpoint,
  });
}
