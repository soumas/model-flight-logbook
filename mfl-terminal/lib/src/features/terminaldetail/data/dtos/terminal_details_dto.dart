import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/src/common/utils/mappable.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_details.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_type.dart';

part 'terminal_details_dto.mapper.dart';

@mappableDto
class TerminalDetailsDto extends TerminalDetails with TerminalDetailsDtoMappable {
  TerminalDetailsDto({
    required super.terminaltype,
    required super.airportname,
    required super.terminalname,
    required super.maxAltitudeM,
    required super.maxAltitudeWithoutObserverM,
    required super.maxNumFlights,
    required super.showPilotIDOnDashboard,
    super.dashboardMessages,
    super.operatinghourEnd,
    super.operatinghourStart,
  });
  TerminalDetails toEntity() => this as TerminalDetails;
}
