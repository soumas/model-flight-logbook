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

  static String _$terminalid(TerminalConfig v) => v.terminalid;
  static const Field<TerminalConfig, String> _f$terminalid =
      Field('terminalid', _$terminalid);
  static String _$terminaltype(TerminalConfig v) => v.terminaltype;
  static const Field<TerminalConfig, String> _f$terminaltype =
      Field('terminaltype', _$terminaltype);
  static String _$airportname(TerminalConfig v) => v.airportname;
  static const Field<TerminalConfig, String> _f$airportname =
      Field('airportname', _$airportname);
  static String _$terminalname(TerminalConfig v) => v.terminalname;
  static const Field<TerminalConfig, String> _f$terminalname =
      Field('terminalname', _$terminalname);
  static String _$pilotidinstruction(TerminalConfig v) => v.pilotidinstruction;
  static const Field<TerminalConfig, String> _f$pilotidinstruction =
      Field('pilotidinstruction', _$pilotidinstruction);

  @override
  final MappableFields<TerminalConfig> fields = const {
    #terminalid: _f$terminalid,
    #terminaltype: _f$terminaltype,
    #airportname: _f$airportname,
    #terminalname: _f$terminalname,
    #pilotidinstruction: _f$pilotidinstruction,
  };

  static TerminalConfig _instantiate(DecodingData data) {
    return TerminalConfig(
        terminalid: data.dec(_f$terminalid),
        terminaltype: data.dec(_f$terminaltype),
        airportname: data.dec(_f$airportname),
        terminalname: data.dec(_f$terminalname),
        pilotidinstruction: data.dec(_f$pilotidinstruction));
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
  $R call(
      {String? terminalid,
      String? terminaltype,
      String? airportname,
      String? terminalname,
      String? pilotidinstruction});
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
  $R call(
          {String? terminalid,
          String? terminaltype,
          String? airportname,
          String? terminalname,
          String? pilotidinstruction}) =>
      $apply(FieldCopyWithData({
        if (terminalid != null) #terminalid: terminalid,
        if (terminaltype != null) #terminaltype: terminaltype,
        if (airportname != null) #airportname: airportname,
        if (terminalname != null) #terminalname: terminalname,
        if (pilotidinstruction != null) #pilotidinstruction: pilotidinstruction
      }));
  @override
  TerminalConfig $make(CopyWithData data) => TerminalConfig(
      terminalid: data.get(#terminalid, or: $value.terminalid),
      terminaltype: data.get(#terminaltype, or: $value.terminaltype),
      airportname: data.get(#airportname, or: $value.airportname),
      terminalname: data.get(#terminalname, or: $value.terminalname),
      pilotidinstruction:
          data.get(#pilotidinstruction, or: $value.pilotidinstruction));

  @override
  TerminalConfigCopyWith<$R2, TerminalConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TerminalConfigCopyWithImpl($value, $cast, t);
}
