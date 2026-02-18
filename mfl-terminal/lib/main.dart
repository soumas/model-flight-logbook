import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/common/widgets/mfl_app.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpoint_state.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MflApp.prepare();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => injector.get<GlobalEndpointsListState>()..load()),
        ChangeNotifierProvider(create: (_) => injector.get<GlobalEndpointState>()..load()),
      ],
      child: const MflApp(),
    ),
  );
}
