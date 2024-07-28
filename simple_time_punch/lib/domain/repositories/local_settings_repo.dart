import 'package:simple_time_punch/domain/entities/local_settings.dart';

abstract class LocalSettingsRepo {
  Future<LocalSettings> load();
  Future save(LocalSettings settings);
}
