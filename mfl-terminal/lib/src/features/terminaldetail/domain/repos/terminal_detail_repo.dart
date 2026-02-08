import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_details.dart';

abstract class TerminalDetailRepo {
  Future<TerminalDetails?> getActiveTerminalDetails(Endpoint? value);
}
