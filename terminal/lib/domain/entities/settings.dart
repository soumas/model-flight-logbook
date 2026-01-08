import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/domain/entities/terminal_endpoint.dart';
import 'package:mfl_terminal/mappable.dart';

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
