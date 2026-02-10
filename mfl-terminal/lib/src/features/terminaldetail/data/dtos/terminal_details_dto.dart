import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/src/common/utils/mappable.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_details.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_type.dart';

part 'terminal_details_dto.mapper.dart';

@mappableDto
class TerminalDetailsDto with TerminalDetailsDtoMappable {
  TerminalDetailsDto({
    required this.terminaltype,
    required this.airportname,
    required this.terminalname,
    required this.maxAltitudeM,
    required this.maxAltitudeWithoutObserverM,
    required this.maxNumFlights,
    required this.showPilotIDOnDashboard,
    this.operatinghourStart,
    this.operatinghourEnd,
    this.dashboardMessages,
  });
  final TerminalType terminaltype;
  final String airportname;
  final String terminalname;
  final int maxAltitudeM;
  final int maxAltitudeWithoutObserverM;
  final int maxNumFlights;
  final bool showPilotIDOnDashboard;
  final DateTime? operatinghourStart;
  final DateTime? operatinghourEnd;
  final List<String>? dashboardMessages;

  TerminalDetails toEntity() {
    return TerminalDetails(
      terminaltype: terminaltype,
      airportname: airportname,
      terminalname: terminalname,
      maxAltitudeM: maxAltitudeM,
      maxAltitudeWithoutObserverM: maxAltitudeWithoutObserverM,
      maxNumFlights: maxNumFlights,
      showPilotIDOnDashboard: showPilotIDOnDashboard,
      operatinghourStart: operatinghourStart,
      operatinghourEnd: operatinghourEnd,
      dashboardMessages: dashboardMessages,
    );
  }
}
