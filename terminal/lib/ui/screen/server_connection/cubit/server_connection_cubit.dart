import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/cubit/server_connection_state.dart';

class ServerConnectionCubit extends Cubit<ServerConnectionState> {
  ServerConnectionCubit({required this.logbookApiRepo}) : super(ServerConnectionState());

  final LogbookApiRepo logbookApiRepo;

  init() async {
    try {
      emit(state.copyWith(loading: true));
    } catch (e) {
      emit(state.copyWith(error: e));
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  loadConfigurations() async {
    try {
      emit(state.copyWith(loading: true));
      final terminalConfigList = await logbookApiRepo.loadTerminalConfigs(apiEndpoint: state.selectedApiEndpoint);
      emit(state.copyWith(configOptions: terminalConfigList));
    } catch (e) {
      emit(state.copyWith(error: e));
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  submit() async {
    try {
      await logbookApiRepo.checkTerminalConnection(apiEndpoint: state.selectedApiEndpoint, apiKey: state.selectedApiKey, terminalid: state.selectedConfig!.terminalid, pilotid: state.selectedPilotId);
      emit(
        state.copyWith(
          result: TerminalEndpoint(
            apiEndpoint: state.selectedApiEndpoint,
            apiKey: state.selectedApiKey,
            pilotid: state.selectedPilotId,
            config: state.selectedConfig!,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e));
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  selectApiEndpoint(String value) {
    emit(state.copyWith(selectedApiEndpoint: value));
  }

  selectApiKey(String value) {
    emit(state.copyWith(selectedApiKey: value));
  }

  selectPilotid(String? value) {
    emit(state.copyWith(selectedPilotId: value));
  }

  selectTerminalconfig(TerminalConfig? value) {
    emit(state.copyWith(selectedConfig: value));
  }
}
