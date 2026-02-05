// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings.dart';

class SettingsMapper extends ClassMapperBase<Settings> {
  SettingsMapper._();

  static SettingsMapper? _instance;
  static SettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsMapper._());
      TerminalEndpointMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Settings';

  static String _$adminPin(Settings v) => v.adminPin;
  static const Field<Settings, String> _f$adminPin = Field(
    'adminPin',
    _$adminPin,
    opt: true,
    def: '',
  );
  static List<TerminalEndpoint> _$terminalEndpoints(Settings v) =>
      v.terminalEndpoints;
  static const Field<Settings, List<TerminalEndpoint>> _f$terminalEndpoints =
      Field('terminalEndpoints', _$terminalEndpoints, opt: true, def: const []);

  @override
  final MappableFields<Settings> fields = const {
    #adminPin: _f$adminPin,
    #terminalEndpoints: _f$terminalEndpoints,
  };

  static Settings _instantiate(DecodingData data) {
    return Settings(
      adminPin: data.dec(_f$adminPin),
      terminalEndpoints: data.dec(_f$terminalEndpoints),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Settings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Settings>(map);
  }

  static Settings fromJson(String json) {
    return ensureInitialized().decodeJson<Settings>(json);
  }
}

mixin SettingsMappable {
  String toJson() {
    return SettingsMapper.ensureInitialized().encodeJson<Settings>(
      this as Settings,
    );
  }

  Map<String, dynamic> toMap() {
    return SettingsMapper.ensureInitialized().encodeMap<Settings>(
      this as Settings,
    );
  }

  SettingsCopyWith<Settings, Settings, Settings> get copyWith =>
      _SettingsCopyWithImpl<Settings, Settings>(
        this as Settings,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SettingsMapper.ensureInitialized().stringifyValue(this as Settings);
  }

  @override
  bool operator ==(Object other) {
    return SettingsMapper.ensureInitialized().equalsValue(
      this as Settings,
      other,
    );
  }

  @override
  int get hashCode {
    return SettingsMapper.ensureInitialized().hashValue(this as Settings);
  }
}

extension SettingsValueCopy<$R, $Out> on ObjectCopyWith<$R, Settings, $Out> {
  SettingsCopyWith<$R, Settings, $Out> get $asSettings =>
      $base.as((v, t, t2) => _SettingsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SettingsCopyWith<$R, $In extends Settings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    TerminalEndpoint,
    TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>
  >
  get terminalEndpoints;
  $R call({String? adminPin, List<TerminalEndpoint>? terminalEndpoints});
  SettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Settings, $Out>
    implements SettingsCopyWith<$R, Settings, $Out> {
  _SettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Settings> $mapper =
      SettingsMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    TerminalEndpoint,
    TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>
  >
  get terminalEndpoints => ListCopyWith(
    $value.terminalEndpoints,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(terminalEndpoints: v),
  );
  @override
  $R call({String? adminPin, List<TerminalEndpoint>? terminalEndpoints}) =>
      $apply(
        FieldCopyWithData({
          if (adminPin != null) #adminPin: adminPin,
          if (terminalEndpoints != null) #terminalEndpoints: terminalEndpoints,
        }),
      );
  @override
  Settings $make(CopyWithData data) => Settings(
    adminPin: data.get(#adminPin, or: $value.adminPin),
    terminalEndpoints: data.get(
      #terminalEndpoints,
      or: $value.terminalEndpoints,
    ),
  );

  @override
  SettingsCopyWith<$R2, Settings, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SettingsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

