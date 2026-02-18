import 'package:dart_mappable/dart_mappable.dart';
import 'package:mfl_terminal/src/common/utils/mappable.dart';

part 'adminpin.mapper.dart';

@mappableEntity
class Adminpin with AdminpinMappable {
  Adminpin({required this.pin});
  final String pin;
}
