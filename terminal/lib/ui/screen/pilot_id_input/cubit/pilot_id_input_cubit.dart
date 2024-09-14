import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/repositories/local_storage_repo.dart';
import 'package:model_flight_logbook/ui/screen/pilot_id_input/cubit/pilot_id_input_state.dart';

class PilotIdInputCubit extends Cubit<PilotIdInputState> {
  PilotIdInputCubit({required this.localStorageRepo}) : super(PilotIdInputState());

  final LocalStorageRepo localStorageRepo;

  load() async {
    try {
      emit(state.copyWith());
      final settings = await localStorageRepo.loadSettings();
      emit(state.copyWith(endpointOptions: settings.terminalEndpoints));
    } catch (e) {
      //emit(state.copyWith(error: e));
      rethrow;
    } finally {
      //emit(state.copyWith(loading: false));
    }
  }
}
