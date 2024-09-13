import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/repositories/local_settings_repo.dart';
import 'package:model_flight_logbook/ui/screen/local_settings/cubit/local_settings_state.dart';

class LocalSettingsCubit extends Cubit<LocalSettingsState> {
  LocalSettingsCubit({required this.localSettingsRepo}) : super(LocalSettingsState());

  final LocalSettingsRepo localSettingsRepo;

  load() async {
    try {
      emit(state.copyWith(loading: true));
      final settings = await localSettingsRepo.load();
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
      await localSettingsRepo.save(state.settings!);
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

  void addOrUpdateEndpointAndSave(TerminalEndpoint endpoint) {
    final lst = [...state.settings!.terminalEndpoints];
    lst.removeWhere((existingep) => endpoint.apiEndpoint.compareTo(existingep.apiEndpoint) == 0 && endpoint.config.terminalid.compareTo(existingep.config.terminalid) == 0);
    lst.add(endpoint);
    emit(state.copyWith(settings: state.settings!.copyWith(terminalEndpoints: lst)));
    save();
  }

  void unlock() {
    emit(state.copyWith(locked: false));
  }
}
