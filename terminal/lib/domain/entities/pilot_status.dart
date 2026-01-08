import 'dart:core';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/mappable.dart';

part 'pilot_status.mapper.dart';

@mappableModelClass
class PilotStatus with PilotStatusMappable {
  final String pilotName;
  final int? sessionId;
  final DateTime? sessionStarttime;
  final List<String>? infoMessages;
  final List<String>? warnMessages;
  final List<String>? errorMessages;
  PilotStatus({
    required this.pilotName,
    this.sessionId,
    this.sessionStarttime,
    this.infoMessages,
    this.warnMessages,
    this.errorMessages,
  });

  bool get isActiveSession => sessionId != null && sessionStarttime != null;
}
