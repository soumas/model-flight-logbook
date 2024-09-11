import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'terminal_config.mapper.dart';

@mappableModelClass
class TerminalConfig with TerminalConfigMappable {
  final String id;
  final String airportname;
  final String terminalname;
  TerminalConfig({
    required this.id,
    required this.airportname,
    required this.terminalname,
  });
}
