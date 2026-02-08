import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';

abstract class EndpointRepo {
  Future<Set<Endpoint>> getEndpoints();
  Future<Endpoint> addEndpoint(Endpoint endpoint);
  Future<Endpoint> updateEndpoint(Endpoint endpoint);
  Future<void> deleteEndpoint(Endpoint endpoint);
  Future<Endpoint> setActiveEndpoint(Endpoint endpoint);
  Future<Endpoint?> getActiveEndpoint();
  Future<void> ping(Endpoint endpoint);
}
