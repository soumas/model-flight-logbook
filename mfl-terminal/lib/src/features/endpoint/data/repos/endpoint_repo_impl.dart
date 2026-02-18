import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mfl_terminal/src/common/utils/storage.dart';
import 'package:mfl_terminal/src/features/endpoint/data/dtos/endpoint_dto.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/repos/endpoint_repo.dart';

class EndpointRepoImpl extends EndpointRepo {
  final _storageKeyList = 'endpoints';
  final _storageKeyActive = 'active_endpoint';

  @override
  Future<Set<Endpoint>> getEndpoints() async {
    String? json = await storage.read(key: _storageKeyList);
    if (json != null) {
      return (jsonDecode(json) as List).map((e) => EndpointDtoMapper.fromMap(e).toEntity()).toSet();
    } else {
      return {};
    }
  }

  @override
  Future<void> setActiveEndpointId(String? endpointId) async {
    if (endpointId != null) {
      await storage.write(key: _storageKeyActive, value: endpointId);
    } else {
      await storage.delete(key: _storageKeyActive);
    }
  }

  @override
  Future<void> deleteEndpoint(Endpoint endpoint) async {
    final lst = await getEndpoints();
    lst.remove(endpoint);
    return _writeEndpoints(lst);
  }

  @override
  Future<Endpoint?> getActiveEndpoint() async {
    String? id = await storage.read(key: _storageKeyActive);
    final lst = await getEndpoints();
    if (id != null && lst.any((e) => e.id == id)) {
      return lst.firstWhere((e) => e.id == id);
    } else {
      return null;
    }
  }

  @override
  Future<Endpoint> addOrUpdateEndpoint(Endpoint endpoint) async {
    final lst = await getEndpoints();
    lst.removeWhere((existingEp) => existingEp.id == endpoint.id);
    lst.add(endpoint);
    await _writeEndpoints(lst);
    return Future.value(endpoint);
  }

  Future<void> _writeEndpoints(Set<Endpoint> endpoints) async {
    return await storage.write(key: _storageKeyList, value: jsonEncode(endpoints.map((e) => EndpointDto.fromEntity(e).toMap()).toList()));
  }

  @override
  Future<void> ping(Endpoint endpoint) async {
    // TODO: dont use dio directly here, but create a separate service for it, which can then also be used for the actual api calls
    final _dio = Dio();
    _dio.options.baseUrl = endpoint.serverurl;
    _dio.options.headers['x-terminal'] = endpoint.terminalid;
    _dio.options.headers['x-api-key'] = endpoint.apikey;
    await _dio.get('/terminal/connectioncheck');
  }
}
