import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/repos/endpoint_repo.dart';

class GlobalEndpointsListState extends ChangeNotifier {
  Set<Endpoint> endpoints = {};

  Future<void> load() async {
    endpoints = await injector.get<EndpointRepo>().getEndpoints();
    notifyListeners();
  }

  Future<void> delete(Endpoint endpoint) async {
    await injector.get<EndpointRepo>().deleteEndpoint(endpoint);
    return load();
  }

  Future<void> addOrUpdate(Endpoint endpoint) async {
    await injector.get<EndpointRepo>().addOrUpdateEndpoint(endpoint);
    return load();
  }

  Future<void> ping(Endpoint endpoint) async {
    await injector.get<EndpointRepo>().ping(endpoint);
  }
}
