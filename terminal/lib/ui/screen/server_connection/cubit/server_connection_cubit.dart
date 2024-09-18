import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/cubit/server_connection_state.dart';

class ServerConnectionCubit extends Cubit<ServerConnectionState> {
  ServerConnectionCubit({required this.logbookApiRepo}) : super(ServerConnectionState());

  final LogbookApiRepo logbookApiRepo;

  loadConfigurations() async {
    try {
      emit(state.copyWith(loading: true, error: null));
      final terminalConfigList = await logbookApiRepo.loadTerminalConfigs(apiEndpoint: state.selectedApiEndpoint);
      emit(state.copyWith(configOptions: terminalConfigList, selectedConfig: terminalConfigList.firstOrNull));
    } catch (e) {
      if (!_handleDioException(e)) {
        emit(state.copyWith(error: e));
      }
      rethrow;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  bool _handleDioException(dynamic e) {
    if (e is DioException) {
      var msg = '';
      switch (e.type) {
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
          msg = 'Zeitüberschreibung';
          break;
        case DioExceptionType.badResponse:
          msg = 'Ungültige Antwort';
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
          msg = 'Fehler beim Verbindungsaufbau';
        case DioExceptionType.unknown:
        default:
          msg = e.message ?? 'Unbekannter Fehler';
      }
      try {
        if (e.response?.data['detail'] != null) {
          msg += ' (${e.response?.data['detail']})';
        }
      } catch (_) {}
      emit(state.copyWith(error: msg));
      return true;
    }
    return false;
  }

  submit() async {
    try {
      await logbookApiRepo.checkTerminalConnection(apiEndpoint: state.selectedApiEndpoint, apiKey: state.selectedApiKey, terminalid: state.selectedConfig!.terminalid, pilotid: state.selectedPilotId);
      emit(
        state.copyWith(
          error: null,
          result: TerminalEndpoint(
            apiEndpoint: state.selectedApiEndpoint,
            apiKey: state.selectedApiKey,
            pilotid: state.selectedPilotId,
            config: state.selectedConfig!,
          ),
        ),
      );
    } catch (e) {
      if (!_handleDioException(e)) {
        emit(state.copyWith(error: e));
      }
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
