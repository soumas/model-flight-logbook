// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'terminal_type.dart';

class TerminalTypeMapper extends EnumMapper<TerminalType> {
  TerminalTypeMapper._();

  static TerminalTypeMapper? _instance;
  static TerminalTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TerminalTypeMapper._());
    }
    return _instance!;
  }

  static TerminalType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TerminalType decode(dynamic value) {
    switch (value) {
      case r'singleuser':
        return TerminalType.singleuser;
      case r'multiuser':
        return TerminalType.multiuser;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TerminalType self) {
    switch (self) {
      case TerminalType.singleuser:
        return r'singleuser';
      case TerminalType.multiuser:
        return r'multiuser';
    }
  }
}

extension TerminalTypeMapperExtension on TerminalType {
  String toValue() {
    TerminalTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TerminalType>(this) as String;
  }
}

