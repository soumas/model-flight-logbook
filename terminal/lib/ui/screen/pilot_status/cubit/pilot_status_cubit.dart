import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/repositories/local_storage_repo.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PilotStatusCubit extends Cubit<PilotStatusState> {
  PilotStatusCubit({
    required this.logbookApiRepo,
    required this.localStorageRepo,
  }) : super(PilotStatusState());

  final LogbookApiRepo logbookApiRepo;
  final LocalStorageRepo localStorageRepo;

  load(String pilotid) async {
    try {
      emit(state.copyWith(loading: true, pilotid: pilotid));
      final fss = await logbookApiRepo.loadPilotStatus(endpoint: await _loadSelectedEndpoint(), pilotid: pilotid);
      emit(state.copyWith(loading: false, flightSessionStatus: fss));
    } catch (e) {
      emit(state.copyWith(loading: false));
      rethrow;
    }
  }

  startSession() async {
    try {
      emit(state.copyWith(loading: true));
      await logbookApiRepo.startFlightSession(endpoint: await _loadSelectedEndpoint(), pilotid: state.pilotid);
      emit(state.copyWith(completedAction: 'startSession'));
    } catch (e) {
      emit(state.copyWith(loading: false));
      rethrow;
    }
  }

  endSession() async {
    try {
      emit(state.copyWith(loading: true));
      await logbookApiRepo.endFlightSession(endpoint: await _loadSelectedEndpoint(), pilotid: state.pilotid);
      emit(state.copyWith(completedAction: 'endSession'));
    } catch (e) {
      emit(state.copyWith(loading: false));
      rethrow;
    }
  }

  Future<TerminalEndpoint> _loadSelectedEndpoint() async {
    final endpoint = await localStorageRepo.loadSelectedTerminalEndpoint();
    if (endpoint == null) {
      throw Exception('NO ENDPOINT SELECTED!');
    }
    return endpoint;
  }
}
