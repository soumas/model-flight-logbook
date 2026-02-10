import 'package:get_it/get_it.dart';
import 'package:mfl_terminal/src/features/endpoint/data/repos/endpoint_repo_impl.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/repos/endpoint_repo.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_active_endpoint_state.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';
import 'package:mfl_terminal/src/features/terminaldetail/data/repos/terminal_detail_repo_impl.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/repos/terminal_detail_repo.dart';

final injector = GetIt.instance;

class MflInjector {
  static void init() {
    // Repos
    injector.registerSingleton<EndpointRepo>(EndpointRepoImpl());
    injector.registerSingleton<TerminalDetailRepo>(TerminalDetailRepoImpl());

    // States (use lazy!)
    injector.registerLazySingleton<GlobalActiveEndpointState>(() => GlobalActiveEndpointState()..load());
    injector.registerLazySingleton<GlobalEndpointsListState>(() => GlobalEndpointsListState()..load());
  }
}
