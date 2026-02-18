import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/src/common/utils/mappable.dart';

part 'endpoint.mapper.dart';

@mappableEntity
class Endpoint with EndpointMappable {
  Endpoint({required this.id, required this.title, required this.serverurl, required this.terminalid, required this.apikey});
  final String id;
  final String title;
  final String serverurl;
  final String terminalid;
  final String apikey;
}
