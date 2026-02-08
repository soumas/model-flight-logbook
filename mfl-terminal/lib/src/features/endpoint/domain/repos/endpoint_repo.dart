import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';

abstract class EndpointRepo {
  Future<Set<Endpoint>> getEndpoints();
  Future<void> addEndpoint(Endpoint endpoint);
  Future<void> updateEndpoint(Endpoint endpoint);
  Future<void> deleteEndpoint(Endpoint endpoint);
  Future<void> setActiveEndpoint(Endpoint endpoint);
  Future<Endpoint?> getActiveEndpoint();
  Future<void> ping(Endpoint endpoint);
}
