import 'package:simple_time_punch_terminal/domain/entities/local_settings.dart';

abstract class LocalSettingsRepo {
  Future<LocalSettings> load();
  Future save(LocalSettings settings);
}
