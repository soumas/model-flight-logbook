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

  connect() async {
    try {
      emit(state.copyWith(loading: true));
      final terminalConfigList = await logbookApiRepo.loadTerminalConfigs(apiEndpoint: state.apiEndpoint, apiKey: state.apiKey);
      if (terminalConfigList.length == 1) {
        submit(terminalConfigList[0]);
      } else {
        emit(state.copyWith(configOptions: terminalConfigList));
      }
    } catch (e) {
      emit(state.copyWith(error: e));
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  submit(TerminalConfig terminalConfig) {
    emit(
      state.copyWith(
        result: TerminalEndpoint(
          apiEndpoint: state.apiEndpoint,
          apiKey: state.apiKey,
          config: terminalConfig,
        ),
      ),
    );
  }

  setApiEndpoint(String value) {
    emit(state.copyWith(apiEndpoint: value));
  }

  setApiKey(String value) {
    emit(state.copyWith(apiKey: value));
  }
}
