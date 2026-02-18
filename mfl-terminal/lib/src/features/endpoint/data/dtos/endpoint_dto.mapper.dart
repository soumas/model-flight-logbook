// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'endpoint_dto.dart';

class EndpointDtoMapper extends ClassMapperBase<EndpointDto> {
  EndpointDtoMapper._();

  static EndpointDtoMapper? _instance;
  static EndpointDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EndpointDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EndpointDto';

  static String _$id(EndpointDto v) => v.id;
  static const Field<EndpointDto, String> _f$id = Field('id', _$id);
  static String _$title(EndpointDto v) => v.title;
  static const Field<EndpointDto, String> _f$title = Field('title', _$title);
  static String _$serverurl(EndpointDto v) => v.serverurl;
  static const Field<EndpointDto, String> _f$serverurl = Field(
    'serverurl',
    _$serverurl,
  );
  static String _$terminalid(EndpointDto v) => v.terminalid;
  static const Field<EndpointDto, String> _f$terminalid = Field(
    'terminalid',
    _$terminalid,
  );
  static String _$apikey(EndpointDto v) => v.apikey;
  static const Field<EndpointDto, String> _f$apikey = Field('apikey', _$apikey);

  @override
  final MappableFields<EndpointDto> fields = const {
    #id: _f$id,
    #title: _f$title,
    #serverurl: _f$serverurl,
    #terminalid: _f$terminalid,
    #apikey: _f$apikey,
  };

  static EndpointDto _instantiate(DecodingData data) {
    return EndpointDto(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      serverurl: data.dec(_f$serverurl),
      terminalid: data.dec(_f$terminalid),
      apikey: data.dec(_f$apikey),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EndpointDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EndpointDto>(map);
  }

  static EndpointDto fromJson(String json) {
    return ensureInitialized().decodeJson<EndpointDto>(json);
  }
}

mixin EndpointDtoMappable {
  String toJson() {
    return EndpointDtoMapper.ensureInitialized().encodeJson<EndpointDto>(
      this as EndpointDto,
    );
  }

  Map<String, dynamic> toMap() {
    return EndpointDtoMapper.ensureInitialized().encodeMap<EndpointDto>(
      this as EndpointDto,
    );
  }

  @override
  String toString() {
    return EndpointDtoMapper.ensureInitialized().stringifyValue(
      this as EndpointDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return EndpointDtoMapper.ensureInitialized().equalsValue(
      this as EndpointDto,
      other,
    );
  }

  @override
  int get hashCode {
    return EndpointDtoMapper.ensureInitialized().hashValue(this as EndpointDto);
  }
}

