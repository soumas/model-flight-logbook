import 'package:dart_mappable/dart_mappable.dart';
import 'package:simple_time_punch/mappable.dart';

part 'local_settings.mapper.dart';

@mappableModelClass
class LocalSettings with LocalSettingsMappable {
  LocalSettings({
    required this.kimaiEndpoint,
    required this.kimaiToken,
  });

  final String kimaiEndpoint;
  final String kimaiToken;
}
