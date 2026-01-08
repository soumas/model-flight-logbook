import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/repositories/local_storage_repo.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';
import 'package:model_flight_logbook/ui/screen/flight_session_list/cubit/flight_session_list_state.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';

class FlightSessionListCubit extends Cubit<FlightSessionListState> {
  FlightSessionListCubit({required this.logbookApiRepo, required this.localStorageRepo}) : super(FlightSessionListState());

  final LogbookApiRepo logbookApiRepo;
  final LocalStorageRepo localStorageRepo;

  load({required String pilotId, required int year}) async {
    try {
      emit(state.copyWith(loading: true));
      final sessionLst = await logbookApiRepo.loadFlightSessions(
          endpoint: await PilotStatusCubit.loadSelectedEndpoint(localStorageRepo), pilotid: pilotId, year: year);
      emit(state.copyWith(flightSessions: sessionLst));
    } catch (e) {
      // TODO
      emit(state.copyWith(loading: false));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
