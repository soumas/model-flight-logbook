// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
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

  static bool _$loading(ServerConnectionState v) => v.loading;
  static const Field<ServerConnectionState, bool> _f$loading =
      Field('loading', _$loading, opt: true, def: false);
  static String _$apiEndpoint(ServerConnectionState v) => v.apiEndpoint;
  static const Field<ServerConnectionState, String> _f$apiEndpoint =
      Field('apiEndpoint', _$apiEndpoint, opt: true, def: '');
  static String _$apiKey(ServerConnectionState v) => v.apiKey;
  static const Field<ServerConnectionState, String> _f$apiKey =
      Field('apiKey', _$apiKey, opt: true, def: '');
  static List<TerminalConfig> _$configOptions(ServerConnectionState v) =>
      v.configOptions;
  static const Field<ServerConnectionState, List<TerminalConfig>>
      _f$configOptions =
      Field('configOptions', _$configOptions, opt: true, def: const []);
  static TerminalEndpoint? _$result(ServerConnectionState v) => v.result;
  static const Field<ServerConnectionState, TerminalEndpoint> _f$result =
      Field('result', _$result, opt: true);
  static dynamic _$error(ServerConnectionState v) => v.error;
  static const Field<ServerConnectionState, dynamic> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<ServerConnectionState> fields = const {
    #loading: _f$loading,
    #apiEndpoint: _f$apiEndpoint,
    #apiKey: _f$apiKey,
    #configOptions: _f$configOptions,
    #result: _f$result,
    #error: _f$error,
  };

  static ServerConnectionState _instantiate(DecodingData data) {
    return ServerConnectionState(
        loading: data.dec(_f$loading),
        apiEndpoint: data.dec(_f$apiEndpoint),
        apiKey: data.dec(_f$apiKey),
        configOptions: data.dec(_f$configOptions),
        result: data.dec(_f$result),
        error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin ServerConnectionStateMappable {
  ServerConnectionStateCopyWith<ServerConnectionState, ServerConnectionState,
          ServerConnectionState>
      get copyWith => _ServerConnectionStateCopyWithImpl(
          this as ServerConnectionState, $identity, $identity);
  @override
  String toString() {
    return ServerConnectionStateMapper.ensureInitialized()
        .stringifyValue(this as ServerConnectionState);
  }

  @override
  bool operator ==(Object other) {
    return ServerConnectionStateMapper.ensureInitialized()
        .equalsValue(this as ServerConnectionState, other);
  }

  @override
  int get hashCode {
    return ServerConnectionStateMapper.ensureInitialized()
        .hashValue(this as ServerConnectionState);
  }
}

extension ServerConnectionStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerConnectionState, $Out> {
  ServerConnectionStateCopyWith<$R, ServerConnectionState, $Out>
      get $asServerConnectionState =>
          $base.as((v, t, t2) => _ServerConnectionStateCopyWithImpl(v, t, t2));
}

abstract class ServerConnectionStateCopyWith<
    $R,
    $In extends ServerConnectionState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, TerminalConfig,
          TerminalConfigCopyWith<$R, TerminalConfig, TerminalConfig>>
      get configOptions;
  TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>? get result;
  $R call(
      {bool? loading,
      String? apiEndpoint,
      String? apiKey,
      List<TerminalConfig>? configOptions,
      TerminalEndpoint? result,
      dynamic error});
  ServerConnectionStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ServerConnectionStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerConnectionState, $Out>
    implements ServerConnectionStateCopyWith<$R, ServerConnectionState, $Out> {
  _ServerConnectionStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerConnectionState> $mapper =
      ServerConnectionStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, TerminalConfig,
          TerminalConfigCopyWith<$R, TerminalConfig, TerminalConfig>>
      get configOptions => ListCopyWith($value.configOptions,
          (v, t) => v.copyWith.$chain(t), (v) => call(configOptions: v));
  @override
  TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>?
      get result => $value.result?.copyWith.$chain((v) => call(result: v));
  @override
  $R call(
          {bool? loading,
          String? apiEndpoint,
          String? apiKey,
          List<TerminalConfig>? configOptions,
          Object? result = $none,
          Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (loading != null) #loading: loading,
        if (apiEndpoint != null) #apiEndpoint: apiEndpoint,
        if (apiKey != null) #apiKey: apiKey,
        if (configOptions != null) #configOptions: configOptions,
        if (result != $none) #result: result,
        if (error != $none) #error: error
      }));
  @override
  ServerConnectionState $make(CopyWithData data) => ServerConnectionState(
      loading: data.get(#loading, or: $value.loading),
      apiEndpoint: data.get(#apiEndpoint, or: $value.apiEndpoint),
      apiKey: data.get(#apiKey, or: $value.apiKey),
      configOptions: data.get(#configOptions, or: $value.configOptions),
      result: data.get(#result, or: $value.result),
      error: data.get(#error, or: $value.error));

  @override
  ServerConnectionStateCopyWith<$R2, ServerConnectionState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ServerConnectionStateCopyWithImpl($value, $cast, t);
}
