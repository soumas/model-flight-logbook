import 'dart:convert';
import 'dart:io';

import 'package:dronedpace_logbook_terminal/data/repositories/local_settings_repo_impl.dart';
import 'package:dronedpace_logbook_terminal/domain/entities/flight_session_status.dart';
import 'package:dronedpace_logbook_terminal/domain/repositories/logbook_api_repo.dart';

class LogbookApiRepoImpl implements LogbookApiRepo {
  final _http = HttpClient();

  @override
  Future<FlightSessionStatus> getFlightSessionStatus({required String pilotid}) async {
    final request = await _http.get('127.0.0.1', 8065, '/terminal/flightsession/status');
    request.headers.add('x-api-key', LocalSettingsRepoImpl.cachedApiKey);
    request.headers.add('x-pilotid', pilotid);
    HttpClientResponse response = await request.close();
    final jsonstr = await response.transform(utf8.decoder).join();
    final elem = FlightSessionStatusMapper.fromJson(jsonstr);
    return elem;
  }

  @override
  Future endFlightSession({required String pilotid}) async {
    final request = await _http.post('127.0.0.1', 8065, '/terminal/flightsession/end');
    request.headers.add('x-api-key', LocalSettingsRepoImpl.cachedApiKey);
    request.headers.add('x-pilotid', pilotid);
    const body = '{"takeoffcount": 5, "comment": ""}';
    request.contentLength = body.length;
    request.write(body);
    return request.close();
  }

  @override
  Future startFlightSession({required String pilotid}) async {
    final request = await _http.post('127.0.0.1', 8065, '/terminal/flightsession/start');
    request.headers.add('x-api-key', LocalSettingsRepoImpl.cachedApiKey);
    request.headers.add('x-pilotid', pilotid);
    return request.close();
  }
}
