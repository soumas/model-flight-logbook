import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_details.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/repos/endpoint_repo.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/repos/terminal_detail_repo.dart';

class GlobalEndpointState extends ChangeNotifier {
  final ValueNotifier<Endpoint?> activeEndpoint = ValueNotifier(null);
  final ValueNotifier<TerminalDetails?> activeTerminalDetails = ValueNotifier(null);
  final ValueNotifier<dynamic> activeTerminalDetailsUpdateError = ValueNotifier(null);
  late final Timer _refreshTimer;
  DateTime _lastTerminalDetailsUpdate = DateTime.now();

  GlobalEndpointState() {
    _refreshTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      // Refresh terminal details every 10 seconds if there was an error or if the last update was more than 30 minutes ago
      if (activeTerminalDetailsUpdateError.value != null || DateTime.now().difference(_lastTerminalDetailsUpdate) > Duration(minutes: 30)) {
        _loadActiveTerminalDetails();
      }
    });
  }

  Future<void> load() async {
    _loadActiveTerminalDetails();
  }

  void setActiveEndpoint(Endpoint? endpoint) async {
    await injector.get<EndpointRepo>().setActiveEndpointId(endpoint?.id);
    _loadActiveTerminalDetails();
  }

  Future<void> _loadActiveTerminalDetails() async {
    _lastTerminalDetailsUpdate = DateTime.now();
    log(_lastTerminalDetailsUpdate.toIso8601String(), name: 'GlobalEndpointState._loadActiveTerminalDetails');
    try {
      activeEndpoint.value = await injector.get<EndpointRepo>().getActiveEndpoint();

      if (activeEndpoint.value == null && injector.get<GlobalEndpointsListState>().endpoints.isNotEmpty) {
        activeEndpoint.value = injector.get<GlobalEndpointsListState>().endpoints.first;
      }

      if (activeEndpoint.value != null) {
        final details = await injector.get<TerminalDetailRepo>().getActiveTerminalDetails(activeEndpoint.value);
        activeTerminalDetailsUpdateError.value = null;
        activeTerminalDetails.value = details;
      } else {
        activeTerminalDetailsUpdateError.value = null;
        activeTerminalDetails.value = null;
      }
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
