// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'terminal_config.dart';

class TerminalConfigMapper extends ClassMapperBase<TerminalConfig> {
  TerminalConfigMapper._();

  static TerminalConfigMapper? _instance;
  static TerminalConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TerminalConfigMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TerminalConfig';

  static String _$id(TerminalConfig v) => v.id;
  static const Field<TerminalConfig, String> _f$id = Field('id', _$id);
  static String _$airportname(TerminalConfig v) => v.airportname;
  static const Field<TerminalConfig, String> _f$airportname =
      Field('airportname', _$airportname);
  static String _$terminalname(TerminalConfig v) => v.terminalname;
  static const Field<TerminalConfig, String> _f$terminalname =
      Field('terminalname', _$terminalname);

  @override
  final MappableFields<TerminalConfig> fields = const {
    #id: _f$id,
    #airportname: _f$airportname,
    #terminalname: _f$terminalname,
  };

  static TerminalConfig _instantiate(DecodingData data) {
    return TerminalConfig(
        id: data.dec(_f$id),
        airportname: data.dec(_f$airportname),
        terminalname: data.dec(_f$terminalname));
  }

  @override
  final Function instantiate = _instantiate;

  static TerminalConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TerminalConfig>(map);
  }

  static TerminalConfig fromJson(String json) {
    return ensureInitialized().decodeJson<TerminalConfig>(json);
  }
}

mixin TerminalConfigMappable {
  String toJson() {
    return TerminalConfigMapper.ensureInitialized()
        .encodeJson<TerminalConfig>(this as TerminalConfig);
  }

  Map<String, dynamic> toMap() {
    return TerminalConfigMapper.ensureInitialized()
        .encodeMap<TerminalConfig>(this as TerminalConfig);
  }

  TerminalConfigCopyWith<TerminalConfig, TerminalConfig, TerminalConfig>
      get copyWith => _TerminalConfigCopyWithImpl(
          this as TerminalConfig, $identity, $identity);
  @override
  String toString() {
    return TerminalConfigMapper.ensureInitialized()
        .stringifyValue(this as TerminalConfig);
  }

  @override
  bool operator ==(Object other) {
    return TerminalConfigMapper.ensureInitialized()
        .equalsValue(this as TerminalConfig, other);
  }

  @override
  int get hashCode {
    return TerminalConfigMapper.ensureInitialized()
        .hashValue(this as TerminalConfig);
  }
}

extension TerminalConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TerminalConfig, $Out> {
  TerminalConfigCopyWith<$R, TerminalConfig, $Out> get $asTerminalConfig =>
      $base.as((v, t, t2) => _TerminalConfigCopyWithImpl(v, t, t2));
}

abstract class TerminalConfigCopyWith<$R, $In extends TerminalConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? airportname, String? terminalname});
  TerminalConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TerminalConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TerminalConfig, $Out>
    implements TerminalConfigCopyWith<$R, TerminalConfig, $Out> {
  _TerminalConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TerminalConfig> $mapper =
      TerminalConfigMapper.ensureInitialized();
  @override
  $R call({String? id, String? airportname, String? terminalname}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (airportname != null) #airportname: airportname,
        if (terminalname != null) #terminalname: terminalname
      }));
  @override
  TerminalConfig $make(CopyWithData data) => TerminalConfig(
      id: data.get(#id, or: $value.id),
      airportname: data.get(#airportname, or: $value.airportname),
      terminalname: data.get(#terminalname, or: $value.terminalname));

  @override
  TerminalConfigCopyWith<$R2, TerminalConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TerminalConfigCopyWithImpl($value, $cast, t);
}
