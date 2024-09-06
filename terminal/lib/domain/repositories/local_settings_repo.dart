import 'package:model_flight_logbook/domain/entities/local_settings.dart';

abstract class LocalSettingsRepo {
  Future<LocalSettings> load();
  Future save(LocalSettings settings);
}
