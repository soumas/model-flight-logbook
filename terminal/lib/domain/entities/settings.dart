import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'settings.mapper.dart';

@mappableModelClass
class Settings with SettingsMappable {
  final String adminPin;
  final List<TerminalEndpoint> terminalEndpoints;
  Settings({
    this.adminPin = '',
    this.terminalEndpoints = const [],
  });
}
