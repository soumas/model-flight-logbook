import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mfl_terminal/src/features/adminpin/data/repos/adminpin_repo_impl.dart';
import 'package:mfl_terminal/src/features/adminpin/domain/repos/adminpin_repo.dart';
import 'package:mfl_terminal/src/features/endpoint/data/repos/endpoint_repo_impl.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/repos/endpoint_repo.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpoint_state.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';
import 'package:mfl_terminal/src/features/terminaldetail/data/repos/terminal_detail_repo_impl.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/repos/terminal_detail_repo.dart';

final injector = GetIt.instance;

class MflInjector {
  static void init() {
    // Repos
    injector.registerSingleton<EndpointRepo>(EndpointRepoImpl());
    injector.registerSingleton<TerminalDetailRepo>(TerminalDetailRepoImpl());
    injector.registerSingleton<AdminpinRepo>(AdminpinRepoImpl());

    // States (use lazy!)
    injector.registerLazySingleton<GlobalEndpointState>(() => GlobalEndpointState()..load());
    injector.registerLazySingleton<GlobalEndpointsListState>(() => GlobalEndpointsListState()..load());

    // others
    injector.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  }
}
