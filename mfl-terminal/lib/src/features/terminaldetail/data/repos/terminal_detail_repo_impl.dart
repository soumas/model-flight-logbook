import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/terminaldetail/data/dtos/terminal_details_dto.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/entities/terminal_details.dart';
import 'package:mfl_terminal/src/features/terminaldetail/domain/repos/terminal_detail_repo.dart';

class TerminalDetailRepoImpl extends TerminalDetailRepo {
  @override
  Future<TerminalDetails?> getActiveTerminalDetails(Endpoint? value) {
    if (value == null) return Future.value(null);
    // TODO: dont use dio directly here, but create a separate service for it, which can then also be used for the actual api calls
    final _dio = Dio();
    _dio.options.baseUrl = value.serverurl;
    _dio.options.headers['x-terminal'] = value.terminalid;
    _dio.options.headers['x-api-key'] = value.apikey;
    return _dio.get('/terminal/details').then((response) => TerminalDetailsDtoMapper.fromJson(jsonEncode(response.data)).toEntity());
  }
}
