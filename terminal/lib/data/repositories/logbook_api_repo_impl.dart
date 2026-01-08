import 'package:dio/dio.dart';
import 'package:model_flight_logbook/domain/entities/end_flight_session_data.dart';
import 'package:model_flight_logbook/domain/entities/flight_session.dart';
import 'package:model_flight_logbook/domain/entities/pilot_status.dart';
import 'package:model_flight_logbook/domain/entities/terminal_config.dart';
import 'package:model_flight_logbook/domain/entities/terminal_endpoint.dart';
import 'package:model_flight_logbook/domain/entities/terminal_status.dart';
import 'package:model_flight_logbook/domain/repositories/logbook_api_repo.dart';

class LogbookApiRepoImpl implements LogbookApiRepo {
  final _dio = Dio();

  @override
  Future<PilotStatus> loadPilotStatus({required TerminalEndpoint endpoint, required String pilotid}) async {
    _prepareDio(endpoint, pilotid);
    final response = await _dio.get('/terminal/flightsession/status');
    return PilotStatusMapper.fromMap(response.data);
  }

  @override
  Future endFlightSession({required TerminalEndpoint endpoint, required String pilotid, required EndFlightSessionData data}) async {
    _prepareDio(endpoint, pilotid);
    return _dio.post('/terminal/flightsession/end', data: data.toJson());
  }

  @override
  Future startFlightSession({required TerminalEndpoint endpoint, required String pilotid}) async {
    _prepareDio(endpoint, pilotid);
    return _dio.post('/terminal/flightsession/start');
  }

  @override
  Future<List<TerminalConfig>> loadTerminalConfigs({required String apiEndpoint}) async {
    _dio.options.baseUrl = apiEndpoint;
    final response = await _dio.get('/public/terminalconfiglist');
    return response.data.map<TerminalConfig>((item) => TerminalConfigMapper.fromMap(item)).toList();
  }

  @override
  Future<void> checkTerminalConnection(
      {required String apiEndpoint, required String terminalid, required String apiKey, String? pilotid}) async {
    _dio.options.baseUrl = apiEndpoint;
    _dio.options.headers['x-terminal'] = terminalid;
    _dio.options.headers['x-api-key'] = apiKey;
    if (pilotid != null) {
      _dio.options.headers['x-pilotid'] = pilotid;
    }
    await _dio.get('/terminal/connectioncheck');
  }

  @override
  Future<TerminalStatus> loadTerminalStatus({required TerminalEndpoint endpoint}) async {
    _dio.options.baseUrl = endpoint.apiEndpoint;
    _dio.options.headers['x-terminal'] = endpoint.config.terminalid;
    _dio.options.headers['x-api-key'] = endpoint.apiKey;
    final response = await _dio.get('/terminal/status');
    return TerminalStatusMapper.fromMap(response.data).copyWith(statusReceiveTime: DateTime.now());
  }

  @override
  Future<List<FlightSession>> loadFlightSessions({required TerminalEndpoint endpoint, required String pilotid, required int year}) async {
    _prepareDio(endpoint, pilotid);
    final response = await _dio.get('/terminal/flightsession/list/$year');
    return response.data.map<FlightSession>((item) => FlightSessionMapper.fromMap(item)).toList();
  }

  void _prepareDio(TerminalEndpoint endpoint, String pilotid) {
    _dio.options.baseUrl = endpoint.apiEndpoint;
    _dio.options.sendTimeout = const Duration(seconds: 5);
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
    _dio.options.headers['x-api-key'] = endpoint.apiKey;
    _dio.options.headers['x-terminal'] = endpoint.config.terminalid;
    _dio.options.headers['x-pilotid'] = pilotid;
  }
}
