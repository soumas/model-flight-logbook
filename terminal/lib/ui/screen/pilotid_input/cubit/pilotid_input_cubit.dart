import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/repositories/local_storage_repo.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_state.dart';

class PilotidInputCubit extends Cubit<PilotidInputState> {
  PilotidInputCubit({required this.localStorageRepo}) : super(PilotidInputState());

  final LocalStorageRepo localStorageRepo;

  init() async {
    try {
      final settings = await localStorageRepo.loadSettings();
      var selectedEndpoint = await localStorageRepo.loadSelectedTerminalEndpoint();
      if (selectedEndpoint == null && settings.terminalEndpoints.isNotEmpty) {
        selectedEndpoint = settings.terminalEndpoints.first;
      } else if (selectedEndpoint != null && settings.terminalEndpoints.isEmpty) {
        selectedEndpoint = null;
      }
      emit(state.copyWith(endpointOptions: settings.terminalEndpoints, selectedEndpoint: selectedEndpoint));
    } catch (e) {
      rethrow;
    }
  }

  selectEndpoint(TerminalEndpoint opt) async {
    await localStorageRepo.saveSelectedTerminalEndpoint(opt);
    init();
  }
}
