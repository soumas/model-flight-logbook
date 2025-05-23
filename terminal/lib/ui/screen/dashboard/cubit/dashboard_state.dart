import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/entities/terminal_status.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'dashboard_state.mapper.dart';

@mappableStateClass
class DashboardState with DashboardStateMappable {
  final List<TerminalEndpoint> endpointOptions;
  final TerminalEndpoint? selectedEndpoint;
  final TerminalStatus? terminalStatus;
  DashboardState({
    this.endpointOptions = const [],
    this.selectedEndpoint,
    this.terminalStatus,
  });
}
