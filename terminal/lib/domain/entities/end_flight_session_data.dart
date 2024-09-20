import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'end_flight_session_data.mapper.dart';

@mappableModelClass
class EndFlightSessionData with EndFlightSessionDataMappable {
  final int? takeoffcount;
  final String? comment;
  EndFlightSessionData({
    this.takeoffcount,
    this.comment,
  });
}
