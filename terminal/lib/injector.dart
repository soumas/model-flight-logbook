import 'package:model_flight_logbook/data/repositories/logbook_api_repo_impl.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';
import 'package:model_flight_logbook/ui/screen/pilotid_input/cubit/pilotid_input_cubit.dart';
import 'package:model_flight_logbook/ui/screen/pilot_status/cubit/pilot_status_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:model_flight_logbook/data/repositories/local_storage_repo_impl.dart';
import 'package:model_flight_logbook/domain/repositories/local_storage_repo.dart';
import 'package:model_flight_logbook/ui/screen/settings/cubit/settings_cubit.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/cubit/server_connection_cubit.dart';

final injector = GetIt.instance;

initInjector() {
  // singletons
  injector.registerSingleton<LocalStorageRepo>(LocalStorageRepoImpl());
  injector.registerSingleton<LogbookApiRepo>(LogbookApiRepoImpl());

  // factories
  injector.registerFactory<PilotidInputCubit>(() => PilotidInputCubit(localStorageRepo: injector.get()));
  injector.registerFactory<SettingsCubit>(() => SettingsCubit(localStorageRepo: injector.get(), logbookApiRepo: injector.get()));
  injector.registerFactory<PilotStatusCubit>(() => PilotStatusCubit(logbookApiRepo: injector.get(), localStorageRepo: injector.get()));
  injector.registerFactory<ServerConnectionCubit>(() => ServerConnectionCubit(logbookApiRepo: injector.get()));
}
