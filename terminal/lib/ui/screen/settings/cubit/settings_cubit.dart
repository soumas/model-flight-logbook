import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/repositories/local_storage_repo.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.localStorageRepo, required this.logbookApiRepo}) : super(SettingsState());

  final LocalStorageRepo localStorageRepo;
  final LogbookApiRepo logbookApiRepo;

  load() async {
    try {
      emit(state.copyWith(loading: true));
      final settings = await localStorageRepo.loadSettings();
      emit(state.copyWith(settings: settings, locked: settings.adminPin.isNotEmpty));
    } catch (e) {
      emit(state.copyWith(error: e));
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  save() async {
    try {
      emit(state.copyWith(loading: true));
      await localStorageRepo.saveSettings(state.settings!);
    } catch (e) {
      emit(state.copyWith(error: e));
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  void setAdminPinAndSave(String value) {
    emit(state.copyWith(settings: state.settings!.copyWith(adminPin: value)));
    save();
  }

  void deleteEndpointAndSave(TerminalEndpoint endpoint) {
    final lst = [...state.settings!.terminalEndpoints];
    lst.removeWhere((existingep) => endpoint.apiEndpoint.compareTo(existingep.apiEndpoint) == 0 && endpoint.config.terminalid.compareTo(existingep.config.terminalid) == 0);
    emit(state.copyWith(settings: state.settings!.copyWith(terminalEndpoints: lst)));
    save();
  }

  Future<bool> reloadEndpointAndSave(TerminalEndpoint endpoint) async {
    // for now there is no way to fetch a single config - fo fetch all and us only the one we need
    var updated = false;
    try {
      final configs = await logbookApiRepo.loadTerminalConfigs(apiEndpoint: endpoint.apiEndpoint);
      for (final cfg in configs) {
        if (cfg.terminalid.compareTo(endpoint.config.terminalid) == 0) {
          await addOrUpdateEndpointAndSave(endpoint.copyWith(config: cfg), selectSavedEndpoint: false);
          updated = true;
        }
      }
      save();
      return updated;
    } catch (e) {
      // log it mal
      return false;
    }
  }

  Future addOrUpdateEndpointAndSave(TerminalEndpoint endpoint, {bool selectSavedEndpoint = true}) async {
    final lst = [...state.settings!.terminalEndpoints];
    lst.removeWhere((existingep) => endpoint.apiEndpoint.compareTo(existingep.apiEndpoint) == 0 && endpoint.config.terminalid.compareTo(existingep.config.terminalid) == 0);
    lst.add(endpoint);
    emit(state.copyWith(settings: state.settings!.copyWith(terminalEndpoints: lst)));
    await save();
    if (selectSavedEndpoint) {
      await localStorageRepo.saveSelectedTerminalEndpoint(endpoint);
    }
  }

  void unlock() {
    emit(state.copyWith(locked: false));
  }
}
