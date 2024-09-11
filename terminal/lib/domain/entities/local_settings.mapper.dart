// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_settings.dart';

class LocalSettingsMapper extends ClassMapperBase<LocalSettings> {
  LocalSettingsMapper._();

  static LocalSettingsMapper? _instance;
  static LocalSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalSettingsMapper._());
      TerminalEndpointMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalSettings';

  static String _$adminPin(LocalSettings v) => v.adminPin;
  static const Field<LocalSettings, String> _f$adminPin =
      Field('adminPin', _$adminPin, opt: true, def: '');
  static List<TerminalEndpoint> _$terminalEndpoints(LocalSettings v) =>
      v.terminalEndpoints;
  static const Field<LocalSettings, List<TerminalEndpoint>>
      _f$terminalEndpoints =
      Field('terminalEndpoints', _$terminalEndpoints, opt: true, def: const []);

  @override
  final MappableFields<LocalSettings> fields = const {
    #adminPin: _f$adminPin,
    #terminalEndpoints: _f$terminalEndpoints,
  };

  static LocalSettings _instantiate(DecodingData data) {
    return LocalSettings(
        adminPin: data.dec(_f$adminPin),
        terminalEndpoints: data.dec(_f$terminalEndpoints));
  }

  @override
  final Function instantiate = _instantiate;

  static LocalSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalSettings>(map);
  }

  static LocalSettings fromJson(String json) {
    return ensureInitialized().decodeJson<LocalSettings>(json);
  }
}

mixin LocalSettingsMappable {
  String toJson() {
    return LocalSettingsMapper.ensureInitialized()
        .encodeJson<LocalSettings>(this as LocalSettings);
  }

  Map<String, dynamic> toMap() {
    return LocalSettingsMapper.ensureInitialized()
        .encodeMap<LocalSettings>(this as LocalSettings);
  }

  LocalSettingsCopyWith<LocalSettings, LocalSettings, LocalSettings>
      get copyWith => _LocalSettingsCopyWithImpl(
          this as LocalSettings, $identity, $identity);
  @override
  String toString() {
    return LocalSettingsMapper.ensureInitialized()
        .stringifyValue(this as LocalSettings);
  }

  @override
  bool operator ==(Object other) {
    return LocalSettingsMapper.ensureInitialized()
        .equalsValue(this as LocalSettings, other);
  }

  @override
  int get hashCode {
    return LocalSettingsMapper.ensureInitialized()
        .hashValue(this as LocalSettings);
  }
}

extension LocalSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalSettings, $Out> {
  LocalSettingsCopyWith<$R, LocalSettings, $Out> get $asLocalSettings =>
      $base.as((v, t, t2) => _LocalSettingsCopyWithImpl(v, t, t2));
}

abstract class LocalSettingsCopyWith<$R, $In extends LocalSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, TerminalEndpoint,
          TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>>
      get terminalEndpoints;
  $R call({String? adminPin, List<TerminalEndpoint>? terminalEndpoints});
  LocalSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocalSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalSettings, $Out>
    implements LocalSettingsCopyWith<$R, LocalSettings, $Out> {
  _LocalSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalSettings> $mapper =
      LocalSettingsMapper.ensureInitialized();
  @override
  ListCopyWith<$R, TerminalEndpoint,
          TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>>
      get terminalEndpoints => ListCopyWith($value.terminalEndpoints,
          (v, t) => v.copyWith.$chain(t), (v) => call(terminalEndpoints: v));
  @override
  $R call({String? adminPin, List<TerminalEndpoint>? terminalEndpoints}) =>
      $apply(FieldCopyWithData({
        if (adminPin != null) #adminPin: adminPin,
        if (terminalEndpoints != null) #terminalEndpoints: terminalEndpoints
      }));
  @override
  LocalSettings $make(CopyWithData data) => LocalSettings(
      adminPin: data.get(#adminPin, or: $value.adminPin),
      terminalEndpoints:
          data.get(#terminalEndpoints, or: $value.terminalEndpoints));

  @override
  LocalSettingsCopyWith<$R2, LocalSettings, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LocalSettingsCopyWithImpl($value, $cast, t);
}
