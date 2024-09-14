import 'dart:core';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'pilot_status.mapper.dart';

@mappableModelClass
class PilotStatus with PilotStatusMappable {
  final String pilotName;
  final int? sessionId;
  final String? sessionStarttime;
  final String? sessionEndtime;
  final String? flightPlanStatus;
  final List<String>? infoMessages;
  final List<String>? warnMessages;
  final List<String>? errorMessages;
  PilotStatus({
    required this.pilotName,
    this.sessionId,
    this.sessionStarttime,
    this.sessionEndtime,
    this.flightPlanStatus,
    this.infoMessages,
    this.warnMessages,
    this.errorMessages,
  });
}
