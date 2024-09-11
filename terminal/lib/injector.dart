import 'package:model_flight_logbook/data/repositories/logbook_api_repo_impl.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';
import 'package:model_flight_logbook/ui/screen/flight_session_status/cubit/flight_session_status_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:model_flight_logbook/data/repositories/local_settings_repo_impl.dart';
import 'package:model_flight_logbook/domain/repositories/local_settings_repo.dart';
import 'package:model_flight_logbook/ui/screen/local_settings/cubit/local_settings_cubit.dart';
import 'package:model_flight_logbook/ui/screen/server_connection/cubit/server_connection_cubit.dart';

final injector = GetIt.instance;

initInjector() {
  // singletons
  injector.registerSingleton<LocalSettingsRepo>(LocalSettingsRepoImpl());
  injector.registerSingleton<LogbookApiRepo>(LogbookApiRepoImpl());

  // factories
  injector.registerFactory<LocalSettingsCubit>(() => LocalSettingsCubit(localSettingsRepo: injector.get()));
  injector.registerFactory<FlightSessionStatusCubit>(() => FlightSessionStatusCubit(logbookApiRepo: injector.get()));
  injector.registerFactory<ServerConnectionCubit>(() => ServerConnectionCubit(logbookApiRepo: injector.get()));
}
