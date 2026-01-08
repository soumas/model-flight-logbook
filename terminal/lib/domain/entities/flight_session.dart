import 'dart:core';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/mappable.dart';

part 'flight_session.mapper.dart';

@mappableModelClass
class FlightSession with FlightSessionMappable {
  final int id;
  final String pilotid;
  final String terminalid;
  final DateTime start;
  final DateTime? end;
  final int? takeoffcount;
  final int? maxAltitude;
  final bool? airspaceObserver;
  final String? comment;
  final String? pilotname;
  final String? airport;
  final String? endedby;

  FlightSession({
    required this.id,
    required this.pilotid,
    required this.terminalid,
    required this.start,
    this.end,
    this.takeoffcount,
    this.maxAltitude,
    this.airspaceObserver,
    this.comment,
    this.pilotname,
    this.airport,
    this.endedby,
  });
}
