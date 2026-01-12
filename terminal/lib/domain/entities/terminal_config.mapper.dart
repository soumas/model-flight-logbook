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
      TerminalTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TerminalConfig';

  static String _$terminalid(TerminalConfig v) => v.terminalid;
  static const Field<TerminalConfig, String> _f$terminalid =
      Field('terminalid', _$terminalid);
  static TerminalType _$terminaltype(TerminalConfig v) => v.terminaltype;
  static const Field<TerminalConfig, TerminalType> _f$terminaltype =
      Field('terminaltype', _$terminaltype);
  static String _$airportname(TerminalConfig v) => v.airportname;
  static const Field<TerminalConfig, String> _f$airportname =
      Field('airportname', _$airportname);
  static String _$terminalname(TerminalConfig v) => v.terminalname;
  static const Field<TerminalConfig, String> _f$terminalname =
      Field('terminalname', _$terminalname);
  static int _$maxAltitudeM(TerminalConfig v) => v.maxAltitudeM;
  static const Field<TerminalConfig, int> _f$maxAltitudeM =
      Field('maxAltitudeM', _$maxAltitudeM);
  static int _$maxAltitudeWithoutObserverM(TerminalConfig v) =>
      v.maxAltitudeWithoutObserverM;
  static const Field<TerminalConfig, int> _f$maxAltitudeWithoutObserverM =
      Field('maxAltitudeWithoutObserverM', _$maxAltitudeWithoutObserverM);
  static int _$maxNumFlights(TerminalConfig v) => v.maxNumFlights;
  static const Field<TerminalConfig, int> _f$maxNumFlights =
      Field('maxNumFlights', _$maxNumFlights);
  static bool _$showPilotIDOnDashboard(TerminalConfig v) =>
      v.showPilotIDOnDashboard;
  static const Field<TerminalConfig, bool> _f$showPilotIDOnDashboard =
      Field('showPilotIDOnDashboard', _$showPilotIDOnDashboard);

  @override
  final MappableFields<TerminalConfig> fields = const {
    #terminalid: _f$terminalid,
    #terminaltype: _f$terminaltype,
    #airportname: _f$airportname,
    #terminalname: _f$terminalname,
    #maxAltitudeM: _f$maxAltitudeM,
    #maxAltitudeWithoutObserverM: _f$maxAltitudeWithoutObserverM,
    #maxNumFlights: _f$maxNumFlights,
    #showPilotIDOnDashboard: _f$showPilotIDOnDashboard,
  };

  static TerminalConfig _instantiate(DecodingData data) {
    return TerminalConfig(
        terminalid: data.dec(_f$terminalid),
        terminaltype: data.dec(_f$terminaltype),
        airportname: data.dec(_f$airportname),
        terminalname: data.dec(_f$terminalname),
        maxAltitudeM: data.dec(_f$maxAltitudeM),
        maxAltitudeWithoutObserverM: data.dec(_f$maxAltitudeWithoutObserverM),
        maxNumFlights: data.dec(_f$maxNumFlights),
        showPilotIDOnDashboard: data.dec(_f$showPilotIDOnDashboard));
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
      TerminalType? terminaltype,
      String? airportname,
      String? terminalname,
      int? maxAltitudeM,
      int? maxAltitudeWithoutObserverM,
      int? maxNumFlights,
      bool? showPilotIDOnDashboard});
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
          TerminalType? terminaltype,
          String? airportname,
          String? terminalname,
          int? maxAltitudeM,
          int? maxAltitudeWithoutObserverM,
          int? maxNumFlights,
          bool? showPilotIDOnDashboard}) =>
      $apply(FieldCopyWithData({
        if (terminalid != null) #terminalid: terminalid,
        if (terminaltype != null) #terminaltype: terminaltype,
        if (airportname != null) #airportname: airportname,
        if (terminalname != null) #terminalname: terminalname,
        if (maxAltitudeM != null) #maxAltitudeM: maxAltitudeM,
        if (maxAltitudeWithoutObserverM != null)
          #maxAltitudeWithoutObserverM: maxAltitudeWithoutObserverM,
        if (maxNumFlights != null) #maxNumFlights: maxNumFlights,
        if (showPilotIDOnDashboard != null)
          #showPilotIDOnDashboard: showPilotIDOnDashboard
      }));
  @override
  TerminalConfig $make(CopyWithData data) => TerminalConfig(
      terminalid: data.get(#terminalid, or: $value.terminalid),
      terminaltype: data.get(#terminaltype, or: $value.terminaltype),
      airportname: data.get(#airportname, or: $value.airportname),
      terminalname: data.get(#terminalname, or: $value.terminalname),
      maxAltitudeM: data.get(#maxAltitudeM, or: $value.maxAltitudeM),
      maxAltitudeWithoutObserverM: data.get(#maxAltitudeWithoutObserverM,
          or: $value.maxAltitudeWithoutObserverM),
      maxNumFlights: data.get(#maxNumFlights, or: $value.maxNumFlights),
      showPilotIDOnDashboard:
          data.get(#showPilotIDOnDashboard, or: $value.showPilotIDOnDashboard));

  @override
  TerminalConfigCopyWith<$R2, TerminalConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TerminalConfigCopyWithImpl($value, $cast, t);
}
