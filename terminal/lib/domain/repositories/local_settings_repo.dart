import 'package:dronedpace_logbook_terminal/domain/entities/local_settings.dart';

abstract class LocalSettingsRepo {
  Future<LocalSettings> load();
  Future save(LocalSettings settings);
}
