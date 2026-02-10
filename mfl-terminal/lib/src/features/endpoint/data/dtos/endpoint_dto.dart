import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/src/common/utils/mappable.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';

part 'endpoint_dto.mapper.dart';

@mappableDto
class EndpointDto with EndpointDtoMappable {
  EndpointDto({required this.title, required this.serverurl, required this.terminalid, required this.apikey});
  final String title;
  final String serverurl;
  final String terminalid;
  final String apikey;

  Endpoint toEntity() {
    return Endpoint(title: title, serverurl: serverurl, terminalid: terminalid, apikey: apikey);
  }

  static EndpointDto fromEntity(Endpoint entity) {
    return EndpointDto(title: entity.title, serverurl: entity.serverurl, terminalid: entity.terminalid, apikey: entity.apikey);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EndpointDto && other.serverurl == serverurl && other.terminalid == terminalid;
  }

  @override
  int get hashCode {
    return serverurl.hashCode ^ terminalid.hashCode;
  }
}
