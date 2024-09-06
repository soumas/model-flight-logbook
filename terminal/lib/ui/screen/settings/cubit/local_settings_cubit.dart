import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/repositories/local_settings_repo.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/local_settings_state.dart';

class LocalSettingsCubit extends Cubit<LocalSettingsState> {
  LocalSettingsCubit({required this.localSettingsRepo}) : super(LocalSettingsState());

  final LocalSettingsRepo localSettingsRepo;

  load() async {
    try {
      emit(state.copyWith(loading: true));
      final settings = await localSettingsRepo.load();
      emit(state.copyWith(loading: false, settings: settings));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e));
      rethrow;
    }
  }

  save() async {
    try {
      emit(state.copyWith(loading: true));
      await localSettingsRepo.save(state.settings!);
      load();
    } catch (e) {
      emit(state.copyWith(loading: false, error: e));
      rethrow;
    }
  }

  void setApiEndpoint(String value) {
    emit(state.copyWith(settings: state.settings!.copyWith(apiEndpoint: value)));
  }

  void setApiKey(String value) {
    emit(state.copyWith(settings: state.settings!.copyWith(apiKey: value)));
  }
}
