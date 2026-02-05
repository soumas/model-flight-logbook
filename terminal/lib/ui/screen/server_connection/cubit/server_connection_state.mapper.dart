// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'server_connection_state.dart';

class ServerConnectionStateMapper
    extends ClassMapperBase<ServerConnectionState> {
  ServerConnectionStateMapper._();

  static ServerConnectionStateMapper? _instance;
  static ServerConnectionStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerConnectionStateMapper._());
      TerminalConfigMapper.ensureInitialized();
      TerminalEndpointMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServerConnectionState';

  static String _$selectedApiEndpoint(ServerConnectionState v) =>
      v.selectedApiEndpoint;
  static const Field<ServerConnectionState, String> _f$selectedApiEndpoint =
      Field('selectedApiEndpoint', _$selectedApiEndpoint, opt: true, def: '');
  static String _$selectedApiKey(ServerConnectionState v) => v.selectedApiKey;
  static const Field<ServerConnectionState, String> _f$selectedApiKey = Field(
    'selectedApiKey',
    _$selectedApiKey,
    opt: true,
    def: '',
  );
  static String _$selectedPilotId(ServerConnectionState v) => v.selectedPilotId;
  static const Field<ServerConnectionState, String> _f$selectedPilotId = Field(
    'selectedPilotId',
    _$selectedPilotId,
    opt: true,
    def: '',
  );
  static TerminalConfig? _$selectedConfig(ServerConnectionState v) =>
      v.selectedConfig;
  static const Field<ServerConnectionState, TerminalConfig> _f$selectedConfig =
      Field('selectedConfig', _$selectedConfig, opt: true);
  static bool _$loading(ServerConnectionState v) => v.loading;
  static const Field<ServerConnectionState, bool> _f$loading = Field(
    'loading',
    _$loading,
    opt: true,
    def: false,
  );
  static List<TerminalConfig> _$configOptions(ServerConnectionState v) =>
      v.configOptions;
  static const Field<ServerConnectionState, List<TerminalConfig>>
  _f$configOptions = Field(
    'configOptions',
    _$configOptions,
    opt: true,
    def: const [],
  );
  static TerminalEndpoint? _$result(ServerConnectionState v) => v.result;
  static const Field<ServerConnectionState, TerminalEndpoint> _f$result = Field(
    'result',
    _$result,
    opt: true,
  );
  static dynamic _$error(ServerConnectionState v) => v.error;
  static const Field<ServerConnectionState, dynamic> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<ServerConnectionState> fields = const {
    #selectedApiEndpoint: _f$selectedApiEndpoint,
    #selectedApiKey: _f$selectedApiKey,
    #selectedPilotId: _f$selectedPilotId,
    #selectedConfig: _f$selectedConfig,
    #loading: _f$loading,
    #configOptions: _f$configOptions,
    #result: _f$result,
    #error: _f$error,
  };

  static ServerConnectionState _instantiate(DecodingData data) {
    return ServerConnectionState(
      selectedApiEndpoint: data.dec(_f$selectedApiEndpoint),
      selectedApiKey: data.dec(_f$selectedApiKey),
      selectedPilotId: data.dec(_f$selectedPilotId),
      selectedConfig: data.dec(_f$selectedConfig),
      loading: data.dec(_f$loading),
      configOptions: data.dec(_f$configOptions),
      result: data.dec(_f$result),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin ServerConnectionStateMappable {
  ServerConnectionStateCopyWith<
    ServerConnectionState,
    ServerConnectionState,
    ServerConnectionState
  >
  get copyWith =>
      _ServerConnectionStateCopyWithImpl<
        ServerConnectionState,
        ServerConnectionState
      >(this as ServerConnectionState, $identity, $identity);
  @override
  String toString() {
    return ServerConnectionStateMapper.ensureInitialized().stringifyValue(
      this as ServerConnectionState,
    );
  }

  @override
  bool operator ==(Object other) {
    return ServerConnectionStateMapper.ensureInitialized().equalsValue(
      this as ServerConnectionState,
      other,
    );
  }

  @override
  int get hashCode {
    return ServerConnectionStateMapper.ensureInitialized().hashValue(
      this as ServerConnectionState,
    );
  }
}

extension ServerConnectionStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerConnectionState, $Out> {
  ServerConnectionStateCopyWith<$R, ServerConnectionState, $Out>
  get $asServerConnectionState => $base.as(
    (v, t, t2) => _ServerConnectionStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ServerConnectionStateCopyWith<
  $R,
  $In extends ServerConnectionState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  TerminalConfigCopyWith<$R, TerminalConfig, TerminalConfig>?
  get selectedConfig;
  ListCopyWith<
    $R,
    TerminalConfig,
    TerminalConfigCopyWith<$R, TerminalConfig, TerminalConfig>
  >
  get configOptions;
  TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>? get result;
  $R call({
    String? selectedApiEndpoint,
    String? selectedApiKey,
    String? selectedPilotId,
    TerminalConfig? selectedConfig,
    bool? loading,
    List<TerminalConfig>? configOptions,
    TerminalEndpoint? result,
    dynamic error,
  });
  ServerConnectionStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ServerConnectionStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerConnectionState, $Out>
    implements ServerConnectionStateCopyWith<$R, ServerConnectionState, $Out> {
  _ServerConnectionStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerConnectionState> $mapper =
      ServerConnectionStateMapper.ensureInitialized();
  @override
  TerminalConfigCopyWith<$R, TerminalConfig, TerminalConfig>?
  get selectedConfig =>
      $value.selectedConfig?.copyWith.$chain((v) => call(selectedConfig: v));
  @override
  ListCopyWith<
    $R,
    TerminalConfig,
    TerminalConfigCopyWith<$R, TerminalConfig, TerminalConfig>
  >
  get configOptions => ListCopyWith(
    $value.configOptions,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(configOptions: v),
  );
  @override
  TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>?
  get result => $value.result?.copyWith.$chain((v) => call(result: v));
  @override
  $R call({
    String? selectedApiEndpoint,
    String? selectedApiKey,
    String? selectedPilotId,
    Object? selectedConfig = $none,
    bool? loading,
    List<TerminalConfig>? configOptions,
    Object? result = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (selectedApiEndpoint != null)
        #selectedApiEndpoint: selectedApiEndpoint,
      if (selectedApiKey != null) #selectedApiKey: selectedApiKey,
      if (selectedPilotId != null) #selectedPilotId: selectedPilotId,
      if (selectedConfig != $none) #selectedConfig: selectedConfig,
      if (loading != null) #loading: loading,
      if (configOptions != null) #configOptions: configOptions,
      if (result != $none) #result: result,
      if (error != $none) #error: error,
    }),
  );
  @override
  ServerConnectionState $make(CopyWithData data) => ServerConnectionState(
    selectedApiEndpoint: data.get(
      #selectedApiEndpoint,
      or: $value.selectedApiEndpoint,
    ),
    selectedApiKey: data.get(#selectedApiKey, or: $value.selectedApiKey),
    selectedPilotId: data.get(#selectedPilotId, or: $value.selectedPilotId),
    selectedConfig: data.get(#selectedConfig, or: $value.selectedConfig),
    loading: data.get(#loading, or: $value.loading),
    configOptions: data.get(#configOptions, or: $value.configOptions),
    result: data.get(#result, or: $value.result),
    error: data.get(#error, or: $value.error),
  );

  @override
  ServerConnectionStateCopyWith<$R2, ServerConnectionState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ServerConnectionStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

