import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'local_settings.mapper.dart';

@mappableModelClass
class LocalSettings with LocalSettingsMappable {
  LocalSettings({
    this.adminPin = '0000',
    required this.apiEndpoint,
    required this.apiKey,
  });

  final String adminPin;
  final String apiEndpoint;
  final String apiKey;
}
