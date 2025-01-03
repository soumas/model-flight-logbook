import 'dart:core';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'utm_status.mapper.dart';

@mappableModelClass
class UtmStatus with UtmStatusMappable {
  final String utmStatus;
  UtmStatus({
    required this.utmStatus,
  });
}
