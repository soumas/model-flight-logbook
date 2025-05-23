// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dashboard_state.dart';

class DashboardStateMapper extends ClassMapperBase<DashboardState> {
  DashboardStateMapper._();

  static DashboardStateMapper? _instance;
  static DashboardStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DashboardStateMapper._());
      TerminalEndpointMapper.ensureInitialized();
      TerminalStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DashboardState';

  static List<TerminalEndpoint> _$endpointOptions(DashboardState v) =>
      v.endpointOptions;
  static const Field<DashboardState, List<TerminalEndpoint>>
      _f$endpointOptions =
      Field('endpointOptions', _$endpointOptions, opt: true, def: const []);
  static TerminalEndpoint? _$selectedEndpoint(DashboardState v) =>
      v.selectedEndpoint;
  static const Field<DashboardState, TerminalEndpoint> _f$selectedEndpoint =
      Field('selectedEndpoint', _$selectedEndpoint, opt: true);
  static TerminalStatus? _$terminalStatus(DashboardState v) => v.terminalStatus;
  static const Field<DashboardState, TerminalStatus> _f$terminalStatus =
      Field('terminalStatus', _$terminalStatus, opt: true);

  @override
  final MappableFields<DashboardState> fields = const {
    #endpointOptions: _f$endpointOptions,
    #selectedEndpoint: _f$selectedEndpoint,
    #terminalStatus: _f$terminalStatus,
  };

  static DashboardState _instantiate(DecodingData data) {
    return DashboardState(
        endpointOptions: data.dec(_f$endpointOptions),
        selectedEndpoint: data.dec(_f$selectedEndpoint),
        terminalStatus: data.dec(_f$terminalStatus));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin DashboardStateMappable {
  DashboardStateCopyWith<DashboardState, DashboardState, DashboardState>
      get copyWith => _DashboardStateCopyWithImpl(
          this as DashboardState, $identity, $identity);
  @override
  String toString() {
    return DashboardStateMapper.ensureInitialized()
        .stringifyValue(this as DashboardState);
  }

  @override
  bool operator ==(Object other) {
    return DashboardStateMapper.ensureInitialized()
        .equalsValue(this as DashboardState, other);
  }

  @override
  int get hashCode {
    return DashboardStateMapper.ensureInitialized()
        .hashValue(this as DashboardState);
  }
}

extension DashboardStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DashboardState, $Out> {
  DashboardStateCopyWith<$R, DashboardState, $Out> get $asDashboardState =>
      $base.as((v, t, t2) => _DashboardStateCopyWithImpl(v, t, t2));
}

abstract class DashboardStateCopyWith<$R, $In extends DashboardState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, TerminalEndpoint,
          TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>>
      get endpointOptions;
  TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>?
      get selectedEndpoint;
  TerminalStatusCopyWith<$R, TerminalStatus, TerminalStatus>?
      get terminalStatus;
  $R call(
      {List<TerminalEndpoint>? endpointOptions,
      TerminalEndpoint? selectedEndpoint,
      TerminalStatus? terminalStatus});
  DashboardStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DashboardStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DashboardState, $Out>
    implements DashboardStateCopyWith<$R, DashboardState, $Out> {
  _DashboardStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DashboardState> $mapper =
      DashboardStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, TerminalEndpoint,
          TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>>
      get endpointOptions => ListCopyWith($value.endpointOptions,
          (v, t) => v.copyWith.$chain(t), (v) => call(endpointOptions: v));
  @override
  TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>?
      get selectedEndpoint => $value.selectedEndpoint?.copyWith
          .$chain((v) => call(selectedEndpoint: v));
  @override
  TerminalStatusCopyWith<$R, TerminalStatus, TerminalStatus>?
      get terminalStatus => $value.terminalStatus?.copyWith
          .$chain((v) => call(terminalStatus: v));
  @override
  $R call(
          {List<TerminalEndpoint>? endpointOptions,
          Object? selectedEndpoint = $none,
          Object? terminalStatus = $none}) =>
      $apply(FieldCopyWithData({
        if (endpointOptions != null) #endpointOptions: endpointOptions,
        if (selectedEndpoint != $none) #selectedEndpoint: selectedEndpoint,
        if (terminalStatus != $none) #terminalStatus: terminalStatus
      }));
  @override
  DashboardState $make(CopyWithData data) => DashboardState(
      endpointOptions: data.get(#endpointOptions, or: $value.endpointOptions),
      selectedEndpoint:
          data.get(#selectedEndpoint, or: $value.selectedEndpoint),
      terminalStatus: data.get(#terminalStatus, or: $value.terminalStatus));

  @override
  DashboardStateCopyWith<$R2, DashboardState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DashboardStateCopyWithImpl($value, $cast, t);
}
