import 'package:dronedpace_logbook_terminal/data/repositories/logbook_api_repo_impl.dart';
import 'package:dronedpace_logbook_terminal/domain/repositories/logbook_api_repo.dart';
import 'package:dronedpace_logbook_terminal/ui/screen/flight_session_status/cubit/flight_session_status_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dronedpace_logbook_terminal/data/repositories/local_settings_repo_impl.dart';
import 'package:dronedpace_logbook_terminal/domain/repositories/local_settings_repo.dart';
import 'package:dronedpace_logbook_terminal/ui/screen/settings/cubit/local_settings_cubit.dart';

final injector = GetIt.instance;

initInjector() {
  // singletons
  injector.registerSingleton<LocalSettingsRepo>(LocalSettingsRepoImpl());
  injector.registerSingleton<LogbookApiRepo>(LogbookApiRepoImpl());

  // factories
  injector.registerFactory<LocalSettingsCubit>(() => LocalSettingsCubit(localSettingsRepo: injector.get()));
  injector.registerFactory<FlightSessionStatusCubit>(() => FlightSessionStatusCubit(logbookApiRepo: injector.get()));
}
