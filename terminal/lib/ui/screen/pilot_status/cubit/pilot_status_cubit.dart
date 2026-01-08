import 'package:mfl_terminal/domain/entities/end_flight_session_data.dart';
import 'package:mfl_terminal/domain/entities/pilot_status.dart';
import 'package:mfl_terminal/domain/entities/terminal_endpoint.dart';
import 'package:mfl_terminal/domain/repositories/local_storage_repo.dart';
import 'package:mfl_terminal/domain/repositories/logbook_api_repo.dart';
import 'package:mfl_terminal/l10n/generated/app_localizations.dart';
import 'package:mfl_terminal/ui/screen/pilot_status/cubit/pilot_status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfl_terminal/ui/utils/dio_exception_util.dart';

class PilotStatusCubit extends Cubit<PilotStatusState> {
  PilotStatusCubit({
    required this.logbookApiRepo,
    required this.localStorageRepo,
  }) : super(PilotStatusState());

  final LogbookApiRepo logbookApiRepo;
  final LocalStorageRepo localStorageRepo;
  late AppLocalizations localizations;

  init(AppLocalizations localizations, String pilotid) async {
    try {
      this.localizations = localizations;
      _resetMessages();
      emit(state.copyWith(loading: true, pilotid: pilotid));
      final fss = await logbookApiRepo.loadPilotStatus(endpoint: await loadSelectedEndpoint(localStorageRepo), pilotid: pilotid);

      emit(state.copyWith(flightSessionStatus: fss));
    } catch (e) {
      final ps = state.flightSessionStatus ?? PilotStatus(pilotName: '');
      emit(state.copyWith(
          flightSessionStatus: ps.copyWith(errorMessages: [DioExceptionUtil.getUiMessage(e, localizations) ?? e.toString()])));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  startSession() async {
    try {
      _resetMessages();
      emit(state.copyWith(loading: true));
      await logbookApiRepo.startFlightSession(endpoint: await loadSelectedEndpoint(localStorageRepo), pilotid: state.pilotid);
      emit(state.copyWith(completedAction: 'Check-In erfolgreich'));
    } catch (e) {
      final ps = state.flightSessionStatus ?? PilotStatus(pilotName: '');
      emit(state.copyWith(
          flightSessionStatus: ps.copyWith(errorMessages: [DioExceptionUtil.getUiMessage(e, localizations) ?? e.toString()])));
    } finally {
      emit(state.copyWith(loading: false, completedAction: null));
    }
  }

  endSession({required EndFlightSessionData data}) async {
    try {
      _resetMessages();
      emit(state.copyWith(loading: true));
      await logbookApiRepo.endFlightSession(
        endpoint: await loadSelectedEndpoint(localStorageRepo),
        pilotid: state.pilotid,
        data: data,
      );
      emit(state.copyWith(completedAction: 'Check-Out erfolgreich'));
    } catch (e) {
      final ps = state.flightSessionStatus ?? PilotStatus(pilotName: '');
      emit(state.copyWith(
          flightSessionStatus: ps.copyWith(errorMessages: [DioExceptionUtil.getUiMessage(e, localizations) ?? e.toString()])));
    } finally {
      emit(state.copyWith(loading: false, completedAction: null));
    }
  }

  static Future<TerminalEndpoint> loadSelectedEndpoint(LocalStorageRepo lsrepo) async {
    final endpoint = await lsrepo.loadSelectedTerminalEndpoint();
    if (endpoint == null) {
      throw Exception('NO ENDPOINT SELECTED!');
    }
    return endpoint;
  }

  void _resetMessages() {
    final ps = state.flightSessionStatus ?? PilotStatus(pilotName: '');
    emit(
      state.copyWith(
        flightSessionStatus: ps.copyWith(
          errorMessages: [],
          infoMessages: [],
          warnMessages: [],
        ),
      ),
    );
  }
}
