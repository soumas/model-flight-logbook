import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';

abstract class EndpointRepo {
  Future<Set<Endpoint>> getEndpoints();
  Future<Endpoint> addOrUpdateEndpoint(Endpoint endpoint);
  Future<void> deleteEndpoint(Endpoint endpoint);
  Future<void> setActiveEndpointId(String? endpointId);
  Future<Endpoint?> getActiveEndpoint();
  Future<void> ping(Endpoint endpoint);
}
