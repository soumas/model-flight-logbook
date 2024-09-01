import 'package:dart_mappable/dart_mappable.dart';
import 'package:dronedpace_logbook_terminal/mappable.dart';

part 'flight_session_status.mapper.dart';

@mappableModelClass
class FlightSessionStatus with FlightSessionStatusMappable {
  final String pilotName;
  final int? sessionId;
  final String? sessionStarttime;
  final String? sessionEndtime;
  final String? flightPlanStatus;
  FlightSessionStatus({
    required this.pilotName,
    this.sessionId,
    this.sessionStarttime,
    this.sessionEndtime,
    this.flightPlanStatus,
  });
}
