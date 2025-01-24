import 'dart:core';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/enums/utm_sync_status.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'terminal_status.mapper.dart';

@mappableModelClass
class TerminalStatus with TerminalStatusMappable {
  final UtmSyncStatus utmStatus;
  TerminalStatus({
    required this.utmStatus,
  });
}
