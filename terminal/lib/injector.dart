import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mfl_terminal/data/repositories/logbook_api_repo_impl.dart';
import 'package:mfl_terminal/domain/repositories/logbook_api_repo.dart';
import 'package:mfl_terminal/ui/screen/dashboard/cubit/dashboard_cubit.dart';
import 'package:mfl_terminal/ui/screen/flight_session_list/cubit/flight_session_list_cubit.dart';
import 'package:mfl_terminal/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:mfl_terminal/data/repositories/local_storage_repo_impl.dart';
import 'package:mfl_terminal/domain/repositories/local_storage_repo.dart';
import 'package:mfl_terminal/ui/screen/settings/cubit/settings_cubit.dart';
import 'package:mfl_terminal/ui/screen/server_connection/cubit/server_connection_cubit.dart';
import 'package:mfl_terminal/ui/utils/mfl_device_info.dart';

final injector = GetIt.instance;

initInjector() {
  // singletons
  injector.registerSingleton<LocalStorageRepo>(LocalStorageRepoImpl());
  injector.registerSingleton<LogbookApiRepo>(LogbookApiRepoImpl());
  injector.registerSingleton<MflDeviceInfo>(MflDeviceInfo());
  injector.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // factories
  injector.registerFactory<DashboardCubit>(() => DashboardCubit(localStorageRepo: injector.get(), logbookApiRepo: injector.get()));
  injector.registerFactory<SettingsCubit>(() => SettingsCubit(localStorageRepo: injector.get(), logbookApiRepo: injector.get()));
  injector.registerFactory<PilotStatusCubit>(() => PilotStatusCubit(logbookApiRepo: injector.get(), localStorageRepo: injector.get()));
  injector.registerFactory<ServerConnectionCubit>(() => ServerConnectionCubit(logbookApiRepo: injector.get()));
  injector.registerFactory<FlightSessionListCubit>(
      () => FlightSessionListCubit(logbookApiRepo: injector.get(), localStorageRepo: injector.get()));
}
