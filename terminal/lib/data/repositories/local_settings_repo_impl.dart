import 'package:shared_preferences/shared_preferences.dart';
import 'package:dronedpace_logbook_terminal/constants.dart';
import 'package:dronedpace_logbook_terminal/domain/entities/local_settings.dart';
import 'package:dronedpace_logbook_terminal/domain/repositories/local_settings_repo.dart';

class LocalSettingsRepoImpl extends LocalSettingsRepo {
  @override
  Future<LocalSettings> load() async {
    final json = (await SharedPreferences.getInstance()).getString(kLocalStorageKeySettings);
    try {
      return LocalSettingsMapper.fromJson(json!);
    } catch (e) {
      // todo schöner
      return LocalSettings(apiEndpoint: '', apiKey: '');
    }
  }

  @override
  Future save(LocalSettings settings) async {
    return (await SharedPreferences.getInstance()).setString(kLocalStorageKeySettings, settings.toJson());
  }
}
