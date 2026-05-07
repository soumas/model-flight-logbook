import 'package:mfl_terminal/src/common/utils/mappable.dart';

/*part 'pilot_status.mapper.dart';*/

@mappableDto
class PilotStatusDto /*with PilotStatusMappable*/ {
  final String pilotName;
  final int? sessionId;
  final DateTime? sessionStarttime;
  final List<String>? infoMessages;
  final List<String>? warnMessages;
  final List<String>? errorMessages;
  PilotStatusDto({
    required this.pilotName,
    this.sessionId,
    this.sessionStarttime,
    this.infoMessages,
    this.warnMessages,
    this.errorMessages,
  });

  bool get isActiveSession => sessionId != null && sessionStarttime != null;
}
