import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_details.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/repos/endpoint_repo.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/repos/terminal_detail_repo.dart';

class GlobalActiveEndpointState extends ChangeNotifier {
  final ValueNotifier<Endpoint?> activeEndpoint = ValueNotifier(null);
  final ValueNotifier<TerminalDetails?> activeTerminalDetails = ValueNotifier(null);
  final ValueNotifier<dynamic> activeTerminalDetailsUpdateError = ValueNotifier(null);
  late final Timer _refreshTimer;

  GlobalActiveEndpointState() {
    activeEndpoint.addListener(_loadActiveTerminalDetails);
    _refreshTimer = Timer.periodic(Duration(seconds: 15), (timer) => _loadActiveTerminalDetails());
  }

  Future<void> load() async {
    activeEndpoint.value = await injector.get<EndpointRepo>().getActiveEndpoint();
    _loadActiveTerminalDetails();
  }

  void setActiveEndpoint(Endpoint endpoint) async {
    activeEndpoint.value = await injector.get<EndpointRepo>().setActiveEndpoint(endpoint);
  }

  Future<void> _loadActiveTerminalDetails() async {
    try {
      final details = await injector.get<TerminalDetailRepo>().getActiveTerminalDetails(activeEndpoint.value);
      activeTerminalDetailsUpdateError.value = null;
      activeTerminalDetails.value = details;

      // TODO
      // if (activeEndpoint.value != null && details != null) {
      //   final title = '${details.airportname} (${details.terminalname})';
      //   if (activeEndpoint.value!.title != title) {
      //     activeEndpoint.value = await injector.get<EndpointRepo>().updateEndpoint(activeEndpoint.value!.copyWith(title: title));
      //     injector.get<GlobalEndpointsListState>().load();
      //   }
      // }
    } catch (e) {
      activeTerminalDetailsUpdateError.value = e;
      activeTerminalDetails.value = null;
    }
  }

  @override
  void dispose() {
    _refreshTimer.cancel();
    activeEndpoint.dispose();
    activeTerminalDetails.dispose();
    activeTerminalDetailsUpdateError.dispose();
    super.dispose();
  }
}
