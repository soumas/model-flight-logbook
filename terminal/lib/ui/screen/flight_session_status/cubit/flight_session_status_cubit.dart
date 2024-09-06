import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';
import 'package:model_flight_logbook/ui/screen/flight_session_status/cubit/flight_session_status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightSessionStatusCubit extends Cubit<FlightSessionStatusState> {
  FlightSessionStatusCubit({required this.logbookApiRepo}) : super(FlightSessionStatusState());

  final LogbookApiRepo logbookApiRepo;

  load(String pilotid) async {
    try {
      emit(state.copyWith(loading: true, pilotid: pilotid));
      await Future.delayed(Duration(seconds: 1));
      final fss = await logbookApiRepo.getFlightSessionStatus(pilotid: pilotid);
      emit(state.copyWith(loading: false, flightSessionStatus: fss));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e));
    }
  }

  startSession() async {
    try {
      emit(state.copyWith(loading: true));
      await logbookApiRepo.startFlightSession(pilotid: state.pilotid);
      emit(state.copyWith(completedAction: 'startSession'));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e));
    }
  }

  endSession() async {
    try {
      emit(state.copyWith(loading: true));
      await logbookApiRepo.endFlightSession(pilotid: state.pilotid);
      emit(state.copyWith(completedAction: 'endSession'));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e));
    }
  }
}
