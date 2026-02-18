import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/repos/endpoint_repo.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpoint_state.dart';

class GlobalEndpointsListState extends ChangeNotifier {
  Set<Endpoint> endpoints = {};

  Future<void> load() async {
    endpoints = await injector.get<EndpointRepo>().getEndpoints();
    notifyListeners();
  }

  Future<void> delete(Endpoint endpoint) async {
    await injector.get<EndpointRepo>().deleteEndpoint(endpoint);
    await load();
    injector.get<GlobalEndpointState>().setActiveEndpoint(null);
  }

  Future<void> addOrUpdate(Endpoint endpoint) async {
    await injector.get<EndpointRepo>().addOrUpdateEndpoint(endpoint);
    await load();
    injector.get<GlobalEndpointState>().setActiveEndpoint(endpoint);
  }

  Future<void> ping(Endpoint endpoint) async {
    await injector.get<EndpointRepo>().ping(endpoint);
  }
}
