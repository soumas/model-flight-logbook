import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/src/common/utils/mappable.dart';

part 'endpoint.mapper.dart';

@mappableEntity
class Endpoint with EndpointMappable {
  Endpoint({required this.title, required this.serverurl, required this.terminalid, required this.apikey});
  final String title;
  final String serverurl;
  final String terminalid;
  final String apikey;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Endpoint && other.serverurl == serverurl && other.terminalid == terminalid;
  }

  @override
  int get hashCode {
    return serverurl.hashCode ^ terminalid.hashCode;
  }
}
