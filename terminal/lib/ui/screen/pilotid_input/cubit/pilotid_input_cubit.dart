import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/repositories/local_storage_repo.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_state.dart';

class PilotidInputCubit extends Cubit<PilotidInputState> {
  PilotidInputCubit({
    required this.localStorageRepo,
    required this.logbookApiRepo,
  }) : super(PilotidInputState());

  final LocalStorageRepo localStorageRepo;
  final LogbookApiRepo logbookApiRepo;

  Future init() async {
    try {
      emit(state.copyWith(endpointOptions: null, selectedEndpoint: null));
      final settings = await localStorageRepo.loadSettings();
      var selectedEndpoint = await localStorageRepo.loadSelectedTerminalEndpoint();
      if (selectedEndpoint == null && settings.terminalEndpoints.isNotEmpty) {
        selectedEndpoint = settings.terminalEndpoints.first;
      } else if (selectedEndpoint != null && settings.terminalEndpoints.isEmpty) {
        selectedEndpoint = null;
      } else if (selectedEndpoint != null) {
        // refresh selected endpoint with the one in the optionslist (because this one always has current data)
        selectedEndpoint = settings.terminalEndpoints.where((te) => te.apiEndpoint.compareTo(selectedEndpoint!.apiEndpoint) == 0 && te.config.terminalid.compareTo(selectedEndpoint.config.terminalid) == 0).first;
      }
      emit(state.copyWith(endpointOptions: settings.terminalEndpoints, selectedEndpoint: selectedEndpoint));
      updateTerminalState();
    } catch (e) {
      rethrow;
    }
  }

  Future selectEndpoint(TerminalEndpoint opt) async {
    await localStorageRepo.saveSelectedTerminalEndpoint(opt);
    await init();
  }

  Future updateTerminalState() async {
    if (state.selectedEndpoint != null) {
      try {
        final ts = await logbookApiRepo.loadTerminalStatus(endpoint: state.selectedEndpoint!);
        emit(state.copyWith(terminalStatus: ts));
      } catch (e) {
        emit(state.copyWith(terminalStatus: null));
      }
    } else {
      emit(state.copyWith(terminalStatus: null));
    }
  }
}
