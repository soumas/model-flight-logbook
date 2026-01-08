import 'package:mfl_terminal/domain/entities/terminal_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mfl_terminal/constants.dart';
import 'package:mfl_terminal/domain/entities/settings.dart';
import 'package:mfl_terminal/domain/repositories/local_storage_repo.dart';

class LocalStorageRepoImpl extends LocalStorageRepo {
  @override
  Future<Settings> loadSettings() async {
    final json = (await SharedPreferences.getInstance()).getString(kLocalStorageKeySettings);
    try {
      return SettingsMapper.fromJson(json!);
    } catch (e) {
      return Settings();
    }
  }

  @override
  Future saveSettings(Settings settings) async {
    return (await SharedPreferences.getInstance()).setString(kLocalStorageKeySettings, settings.toJson());
  }

  @override
  Future<TerminalEndpoint?> loadSelectedTerminalEndpoint() async {
    final json = (await SharedPreferences.getInstance()).getString(kLocalStorageKeySelectedTerminalEndpoint);
    try {
      return TerminalEndpointMapper.fromJson(json!);
    } catch (e) {
      return null;
    }
  }

  @override
  Future saveSelectedTerminalEndpoint(TerminalEndpoint? endpoint) async {
    if (endpoint == null) {
      return (await SharedPreferences.getInstance()).remove(kLocalStorageKeySelectedTerminalEndpoint);
    } else {
      return (await SharedPreferences.getInstance()).setString(kLocalStorageKeySelectedTerminalEndpoint, endpoint.toJson());
    }
  }
}
