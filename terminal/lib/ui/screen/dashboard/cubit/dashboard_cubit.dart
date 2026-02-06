import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfl_terminal/domain/entities/terminal_endpoint.dart';
import 'package:mfl_terminal/domain/entities/terminal_status.dart';
import 'package:mfl_terminal/domain/repositories/local_storage_repo.dart';
import 'package:mfl_terminal/domain/repositories/logbook_api_repo.dart';
import 'package:mfl_terminal/injector.dart';
import 'package:mfl_terminal/ui/screen/dashboard/cubit/dashboard_state.dart';
import 'package:mfl_terminal/ui/screen/settings/cubit/settings_cubit.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required this.localStorageRepo,
    required this.logbookApiRepo,
  }) : super(DashboardState());

  final LocalStorageRepo localStorageRepo;
  final LogbookApiRepo logbookApiRepo;

  Future init() async {
    try {
      emit(DashboardState());

      // update all terminal endpoints
      var settings = await localStorageRepo.loadSettings();
      for (var te in settings.terminalEndpoints) {
        try {
          // dirty hack to fetch current config for all endponts on startup
          final uglySettingsCubit = injector.get<SettingsCubit>();
          await uglySettingsCubit.load();
          await uglySettingsCubit.reloadEndpointAndSave(te);
        } catch (e) {
          // log it mal
        }
      }

      settings = await localStorageRepo.loadSettings();
      // load selected endpoint
      var selectedEndpoint = await localStorageRepo.loadSelectedTerminalEndpoint();
      if (selectedEndpoint == null && settings.terminalEndpoints.isNotEmpty) {
        selectedEndpoint = settings.terminalEndpoints.first;
      } else if (selectedEndpoint != null && settings.terminalEndpoints.isEmpty) {
        selectedEndpoint = null;
      } else if (selectedEndpoint != null) {
        // refresh selected endpoint with the one in the optionslist (because this one always has current data)
        selectedEndpoint = settings.terminalEndpoints
            .where((te) =>
                te.apiEndpoint.compareTo(selectedEndpoint!.apiEndpoint) == 0 &&
                te.config.terminalid.compareTo(selectedEndpoint.config.terminalid) == 0)
            .first;
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
        final lastSuccUpdate = state.terminalStatus?.statusReceiveTime ?? DateTime.now();
        emit(state.copyWith(
            terminalStatus: TerminalStatus(
                statusReceiveTime: lastSuccUpdate,
                errorMessages: ['Fehler beim Zugriff auf den MFL Server (Zeitpunkt: ${DateFormat.Hm().format(DateTime.now())} Uhr)'])));
      }
    } else {
      emit(state.copyWith(terminalStatus: TerminalStatus(infoMessages: ['Setup erforderlich'])));
    }
  }
}
