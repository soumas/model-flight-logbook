import 'package:shared_preferences/shared_preferences.dart';
import 'package:model_flight_logbook/constants.dart';
import 'package:model_flight_logbook/domain/entities/local_settings.dart';
import 'package:model_flight_logbook/domain/repositories/local_settings_repo.dart';

class LocalSettingsRepoImpl extends LocalSettingsRepo {
  static Future<LocalSettings> loadStatic() async {
    final json = (await SharedPreferences.getInstance()).getString(kLocalStorageKeySettings);
    try {
      return LocalSettingsMapper.fromJson(json!);
    } catch (e) {
      // todo... it nicer
      return LocalSettings();
    }
  }

  @override
  Future<LocalSettings> load() async {
    return loadStatic();
  }

  @override
  Future save(LocalSettings settings) async {
    await (await SharedPreferences.getInstance()).setString(kLocalStorageKeySettings, settings.toJson());
  }
}
