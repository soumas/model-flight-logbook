// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'terminal_endpoint.dart';

class TerminalEndpointMapper extends ClassMapperBase<TerminalEndpoint> {
  TerminalEndpointMapper._();

  static TerminalEndpointMapper? _instance;
  static TerminalEndpointMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TerminalEndpointMapper._());
      TerminalConfigMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TerminalEndpoint';

  static String _$apiEndpoint(TerminalEndpoint v) => v.apiEndpoint;
  static const Field<TerminalEndpoint, String> _f$apiEndpoint = Field(
    'apiEndpoint',
    _$apiEndpoint,
  );
  static String _$apiKey(TerminalEndpoint v) => v.apiKey;
  static const Field<TerminalEndpoint, String> _f$apiKey = Field(
    'apiKey',
    _$apiKey,
  );
  static TerminalConfig _$config(TerminalEndpoint v) => v.config;
  static const Field<TerminalEndpoint, TerminalConfig> _f$config = Field(
    'config',
    _$config,
  );
  static String? _$pilotid(TerminalEndpoint v) => v.pilotid;
  static const Field<TerminalEndpoint, String> _f$pilotid = Field(
    'pilotid',
    _$pilotid,
    opt: true,
  );

  @override
  final MappableFields<TerminalEndpoint> fields = const {
    #apiEndpoint: _f$apiEndpoint,
    #apiKey: _f$apiKey,
    #config: _f$config,
    #pilotid: _f$pilotid,
  };

  static TerminalEndpoint _instantiate(DecodingData data) {
    return TerminalEndpoint(
      apiEndpoint: data.dec(_f$apiEndpoint),
      apiKey: data.dec(_f$apiKey),
      config: data.dec(_f$config),
      pilotid: data.dec(_f$pilotid),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TerminalEndpoint fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TerminalEndpoint>(map);
  }

  static TerminalEndpoint fromJson(String json) {
    return ensureInitialized().decodeJson<TerminalEndpoint>(json);
  }
}

mixin TerminalEndpointMappable {
  String toJson() {
    return TerminalEndpointMapper.ensureInitialized()
        .encodeJson<TerminalEndpoint>(this as TerminalEndpoint);
  }

  Map<String, dynamic> toMap() {
    return TerminalEndpointMapper.ensureInitialized()
        .encodeMap<TerminalEndpoint>(this as TerminalEndpoint);
  }

  TerminalEndpointCopyWith<TerminalEndpoint, TerminalEndpoint, TerminalEndpoint>
  get copyWith =>
      _TerminalEndpointCopyWithImpl<TerminalEndpoint, TerminalEndpoint>(
        this as TerminalEndpoint,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TerminalEndpointMapper.ensureInitialized().stringifyValue(
      this as TerminalEndpoint,
    );
  }

  @override
  bool operator ==(Object other) {
    return TerminalEndpointMapper.ensureInitialized().equalsValue(
      this as TerminalEndpoint,
      other,
    );
  }

  @override
  int get hashCode {
    return TerminalEndpointMapper.ensureInitialized().hashValue(
      this as TerminalEndpoint,
    );
  }
}

extension TerminalEndpointValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TerminalEndpoint, $Out> {
  TerminalEndpointCopyWith<$R, TerminalEndpoint, $Out>
  get $asTerminalEndpoint =>
      $base.as((v, t, t2) => _TerminalEndpointCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TerminalEndpointCopyWith<$R, $In extends TerminalEndpoint, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  TerminalConfigCopyWith<$R, TerminalConfig, TerminalConfig> get config;
  $R call({
    String? apiEndpoint,
    String? apiKey,
    TerminalConfig? config,
    String? pilotid,
  });
  TerminalEndpointCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TerminalEndpointCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TerminalEndpoint, $Out>
    implements TerminalEndpointCopyWith<$R, TerminalEndpoint, $Out> {
  _TerminalEndpointCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TerminalEndpoint> $mapper =
      TerminalEndpointMapper.ensureInitialized();
  @override
  TerminalConfigCopyWith<$R, TerminalConfig, TerminalConfig> get config =>
      $value.config.copyWith.$chain((v) => call(config: v));
  @override
  $R call({
    String? apiEndpoint,
    String? apiKey,
    TerminalConfig? config,
    Object? pilotid = $none,
  }) => $apply(
    FieldCopyWithData({
      if (apiEndpoint != null) #apiEndpoint: apiEndpoint,
      if (apiKey != null) #apiKey: apiKey,
      if (config != null) #config: config,
      if (pilotid != $none) #pilotid: pilotid,
    }),
  );
  @override
  TerminalEndpoint $make(CopyWithData data) => TerminalEndpoint(
    apiEndpoint: data.get(#apiEndpoint, or: $value.apiEndpoint),
    apiKey: data.get(#apiKey, or: $value.apiKey),
    config: data.get(#config, or: $value.config),
    pilotid: data.get(#pilotid, or: $value.pilotid),
  );

  @override
  TerminalEndpointCopyWith<$R2, TerminalEndpoint, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TerminalEndpointCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

