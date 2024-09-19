import 'package:dart_mappable/dart_mappable.dart';

part 'terminal_type.mapper.dart';

@MappableEnum()
enum TerminalType {
  singleuser,
  multiuser,
}
