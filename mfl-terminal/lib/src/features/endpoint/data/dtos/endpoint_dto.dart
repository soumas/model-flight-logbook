import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/src/common/utils/mappable.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';

part 'endpoint_dto.mapper.dart';

@mappableDto
class EndpointDto extends Endpoint with EndpointDtoMappable {
  EndpointDto({required super.title, required super.serverurl, required super.terminalid, required super.apikey});
  Endpoint toEntity() => this as Endpoint;
  static EndpointDto fromEntity(Endpoint entity) =>
      EndpointDto(title: entity.title, serverurl: entity.serverurl, terminalid: entity.terminalid, apikey: entity.apikey);
}
