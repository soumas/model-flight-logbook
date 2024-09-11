import 'package:dio/dio.dart';
import 'package:model_flight_logbook/domain/entities/flight_session_status.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';

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
    // TODO _dio.options.baseUrl = LocalSettingsRepoImpl.cachedApiEndpoint;
    // TODO _dio.options.headers['x-api-key'] = LocalSettingsRepoImpl.cachedApiKey;
    _dio.options.headers['x-pilotid'] = pilotid;
  }

  @override
  Future<List<TerminalConfig>> loadTerminalConfigs({required String apiEndpoint, required String apiKey}) async {
    _dio.options.baseUrl = apiEndpoint;
    _dio.options.headers['x-api-key'] = apiKey;
    final response = await _dio.get('/terminal/config/list');
    return response.data.map<TerminalConfig>((item) => TerminalConfigMapper.fromMap(item)).toList();
  }
}
