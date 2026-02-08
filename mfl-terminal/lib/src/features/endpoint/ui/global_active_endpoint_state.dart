import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_details.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/repos/endpoint_repo.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/repos/terminal_detail_repo.dart';

class GlobalActiveEndpointState extends ChangeNotifier {
  ValueNotifier<Endpoint?> activeEndpoint = ValueNotifier(null);
  ValueNotifier<TerminalDetails?> activeTerminalDetails = ValueNotifier(null);

  GlobalActiveEndpointState() {
    activeEndpoint.addListener(() async {
      activeTerminalDetails.value = await injector.get<TerminalDetailRepo>().getActiveTerminalDetails(activeEndpoint.value);
    });
  }

  Future<void> load() async {
    await injector.get<EndpointRepo>().getActiveEndpoint().then((value) => activeEndpoint.value = value);
  }

  @override
  void dispose() {
    activeEndpoint.dispose();
    activeTerminalDetails.dispose();
    super.dispose();
  }
}
