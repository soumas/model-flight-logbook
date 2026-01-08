import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/domain/entities/terminal_endpoint.dart';
import 'package:mfl_terminal/domain/entities/terminal_status.dart';
import 'package:mfl_terminal/mappable.dart';

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
