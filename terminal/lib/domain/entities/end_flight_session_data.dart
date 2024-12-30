import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'end_flight_session_data.mapper.dart';

@mappableModelClass
class EndFlightSessionData with EndFlightSessionDataMappable {
  final int takeoffcount;
  final int maxAltitude;
  final bool airspaceObserver;
  final String? comment;
  EndFlightSessionData({
    required this.takeoffcount,
    required this.maxAltitude,
    required this.airspaceObserver,
    this.comment,
  });
}
