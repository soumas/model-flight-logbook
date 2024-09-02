import 'package:dio/dio.dart';
import 'package:dronedpace_logbook_terminal/data/repositories/local_settings_repo_impl.dart';
import 'package:dronedpace_logbook_terminal/domain/entities/flight_session_status.dart';
import 'package:dronedpace_logbook_terminal/domain/repositories/logbook_api_repo.dart';

class LogbookApiRepoImpl implements LogbookApiRepo {
  final _dio = Dio();

  @override
  Future<FlightSessionStatus> getFlightSessionStatus({required String pilotid}) async {
    _prepareDio(pilotid);
    final response = await _dio.get('/terminal/flightsession/status');
    return FlightSessionStatusMapper.fromMap(response.data);
  }

  @override
  Future endFlightSession({required String pilotid}) async {
    _prepareDio(pilotid);
    return _dio.post('/terminal/flightsession/end', data: {"takeoffcount": 5, "comment": "bla bla bla 123435"});
  }

  @override
  Future startFlightSession({required String pilotid}) async {
    _prepareDio(pilotid);
    return _dio.post('/terminal/flightsession/start');
  }

  void _prepareDio(String pilotid) {
    _dio.options.baseUrl = LocalSettingsRepoImpl.cachedApiEndpoint;
    _dio.options.headers['x-api-key'] = LocalSettingsRepoImpl.cachedApiKey;
    _dio.options.headers['x-pilotid'] = pilotid;
  }
}
