import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/repos/endpoint_repo.dart';

class GlobalEndpointsListState extends ChangeNotifier {
  ValueNotifier<Set<Endpoint>> endpoints = ValueNotifier({});

  Future<void> load() async {
    injector.get<EndpointRepo>().getEndpoints().then((value) => endpoints.value = value);
    notifyListeners();
  }

  Future<void> deleteEndpoint(Endpoint endpoint) async {
    await injector.get<EndpointRepo>().deleteEndpoint(endpoint);
    return load();
  }

  @override
  void dispose() {
    endpoints.dispose();
    super.dispose();
  }
}
