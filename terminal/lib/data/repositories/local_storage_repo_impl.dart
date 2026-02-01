import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mfl_terminal/domain/entities/terminal_endpoint.dart';
import 'package:mfl_terminal/constants.dart';
import 'package:mfl_terminal/domain/entities/settings.dart';
import 'package:mfl_terminal/domain/repositories/local_storage_repo.dart';
import 'package:mfl_terminal/injector.dart';

class LocalStorageRepoImpl extends LocalStorageRepo {
  @override
  Future<Settings> loadSettings() async {
    final json = await injector.get<FlutterSecureStorage>().read(key: kLocalStorageKeySettings);
    try {
      return SettingsMapper.fromJson(json!);
    } catch (e) {
      return Settings();
    }
  }

  @override
  Future saveSettings(Settings settings) async {
    return injector.get<FlutterSecureStorage>().write(key: kLocalStorageKeySettings, value: settings.toJson());
  }

  @override
  Future<TerminalEndpoint?> loadSelectedTerminalEndpoint() async {
    final json = await injector.get<FlutterSecureStorage>().read(key: kLocalStorageKeySelectedTerminalEndpoint);
    try {
      return TerminalEndpointMapper.fromJson(json!);
    } catch (e) {
      return null;
    }
  }

  @override
  Future saveSelectedTerminalEndpoint(TerminalEndpoint? endpoint) async {
    if (endpoint == null) {
      return injector.get<FlutterSecureStorage>().delete(key: kLocalStorageKeySelectedTerminalEndpoint);
    } else {
      return injector.get<FlutterSecureStorage>().write(key: kLocalStorageKeySelectedTerminalEndpoint, value: endpoint.toJson());
    }
  }
}
