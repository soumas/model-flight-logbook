import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/cubit/server_connection_state.dart';
import 'package:model_flight_logbook/ui/utils/dio_exception_util.dart';

class ServerConnectionCubit extends Cubit<ServerConnectionState> {
  ServerConnectionCubit({required this.logbookApiRepo}) : super(ServerConnectionState());

  final LogbookApiRepo logbookApiRepo;
  late AppLocalizations localizations;

  init(AppLocalizations localizations) {
    this.localizations = localizations;
  }

  loadConfigurations(String endpoint) async {
    try {
      emit(state.copyWith(loading: true, error: null, selectedApiEndpoint: endpoint));
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
    final dioMsg = DioExceptionUtil.getUiMessage(e, localizations);
    if (dioMsg != null) {
      emit(state.copyWith(error: dioMsg));
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
