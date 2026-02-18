// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'adminpin_dto.dart';

class AdminpinDtoMapper extends ClassMapperBase<AdminpinDto> {
  AdminpinDtoMapper._();

  static AdminpinDtoMapper? _instance;
  static AdminpinDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdminpinDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AdminpinDto';

  static String _$pin(AdminpinDto v) => v.pin;
  static const Field<AdminpinDto, String> _f$pin = Field('pin', _$pin);

  @override
  final MappableFields<AdminpinDto> fields = const {#pin: _f$pin};

  static AdminpinDto _instantiate(DecodingData data) {
    return AdminpinDto(pin: data.dec(_f$pin));
  }

  @override
  final Function instantiate = _instantiate;

  static AdminpinDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdminpinDto>(map);
  }

  static AdminpinDto fromJson(String json) {
    return ensureInitialized().decodeJson<AdminpinDto>(json);
  }
}

mixin AdminpinDtoMappable {
  String toJson() {
    return AdminpinDtoMapper.ensureInitialized().encodeJson<AdminpinDto>(
      this as AdminpinDto,
    );
  }

  Map<String, dynamic> toMap() {
    return AdminpinDtoMapper.ensureInitialized().encodeMap<AdminpinDto>(
      this as AdminpinDto,
    );
  }

  @override
  String toString() {
    return AdminpinDtoMapper.ensureInitialized().stringifyValue(
      this as AdminpinDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return AdminpinDtoMapper.ensureInitialized().equalsValue(
      this as AdminpinDto,
      other,
    );
  }

  @override
  int get hashCode {
    return AdminpinDtoMapper.ensureInitialized().hashValue(this as AdminpinDto);
  }
}

