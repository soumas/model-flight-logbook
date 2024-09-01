import 'package:shared_preferences/shared_preferences.dart';
import 'package:dronedpace_logbook_terminal/constants.dart';
import 'package:dronedpace_logbook_terminal/domain/entities/local_settings.dart';
import 'package:dronedpace_logbook_terminal/domain/repositories/local_settings_repo.dart';

class LocalSettingsRepoImpl extends LocalSettingsRepo {
  static String cachedApiEndpoint = '';
  static String cachedApiKey = '';

  static Future<void> initCache() async {
    LocalSettings settings = await loadStatic();
    cachedApiEndpoint = settings.apiEndpoint;
    cachedApiKey = settings.apiKey;
  }

  static Future<LocalSettings> loadStatic() async {
    final json = (await SharedPreferences.getInstance()).getString(kLocalStorageKeySettings);
    try {
      return LocalSettingsMapper.fromJson(json!);
    } catch (e) {
      // todo... it nicer
      return LocalSettings(apiEndpoint: '', apiKey: '');
    }
  }

  @override
  Future<LocalSettings> load() async {
    return loadStatic();
  }

  @override
  Future save(LocalSettings settings) async {
    await (await SharedPreferences.getInstance()).setString(kLocalStorageKeySettings, settings.toJson());
    await initCache();
  }
}
