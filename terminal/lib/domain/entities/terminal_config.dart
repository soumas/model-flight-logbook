import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/enums/terminal_type.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'terminal_config.mapper.dart';

@mappableModelClass
class TerminalConfig with TerminalConfigMappable {
  final String terminalid;
  final TerminalType terminaltype;
  final String airportname;
  final String terminalname;
  final int maxAltitudeM;
  final int maxNumFlights;
  TerminalConfig({
    required this.terminalid,
    required this.terminaltype,
    required this.airportname,
    required this.terminalname,
    required this.maxAltitudeM,
    required this.maxNumFlights,
  });
}
