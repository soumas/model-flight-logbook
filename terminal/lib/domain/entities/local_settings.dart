import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'local_settings.mapper.dart';

@mappableModelClass
class LocalSettings with LocalSettingsMappable {
  final String adminPin;
  final List<TerminalEndpoint> terminalEndpoints;
  LocalSettings({
    this.adminPin = '',
    this.terminalEndpoints = const [],
  });
}
