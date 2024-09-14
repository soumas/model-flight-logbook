// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pilot_id_input_state.dart';

class PilotIdInputStateMapper extends ClassMapperBase<PilotIdInputState> {
  PilotIdInputStateMapper._();

  static PilotIdInputStateMapper? _instance;
  static PilotIdInputStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PilotIdInputStateMapper._());
      TerminalEndpointMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PilotIdInputState';

  static List<TerminalEndpoint> _$endpointOptions(PilotIdInputState v) =>
      v.endpointOptions;
  static const Field<PilotIdInputState, List<TerminalEndpoint>>
      _f$endpointOptions =
      Field('endpointOptions', _$endpointOptions, opt: true, def: const []);
  static TerminalEndpoint? _$selectedEndpoint(PilotIdInputState v) =>
      v.selectedEndpoint;
  static const Field<PilotIdInputState, TerminalEndpoint> _f$selectedEndpoint =
      Field('selectedEndpoint', _$selectedEndpoint, opt: true);

  @override
  final MappableFields<PilotIdInputState> fields = const {
    #endpointOptions: _f$endpointOptions,
    #selectedEndpoint: _f$selectedEndpoint,
  };

  static PilotIdInputState _instantiate(DecodingData data) {
    return PilotIdInputState(
        endpointOptions: data.dec(_f$endpointOptions),
        selectedEndpoint: data.dec(_f$selectedEndpoint));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin PilotIdInputStateMappable {
  PilotIdInputStateCopyWith<PilotIdInputState, PilotIdInputState,
          PilotIdInputState>
      get copyWith => _PilotIdInputStateCopyWithImpl(
          this as PilotIdInputState, $identity, $identity);
  @override
  String toString() {
    return PilotIdInputStateMapper.ensureInitialized()
        .stringifyValue(this as PilotIdInputState);
  }

  @override
  bool operator ==(Object other) {
    return PilotIdInputStateMapper.ensureInitialized()
        .equalsValue(this as PilotIdInputState, other);
  }

  @override
  int get hashCode {
    return PilotIdInputStateMapper.ensureInitialized()
        .hashValue(this as PilotIdInputState);
  }
}

extension PilotIdInputStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PilotIdInputState, $Out> {
  PilotIdInputStateCopyWith<$R, PilotIdInputState, $Out>
      get $asPilotIdInputState =>
          $base.as((v, t, t2) => _PilotIdInputStateCopyWithImpl(v, t, t2));
}

abstract class PilotIdInputStateCopyWith<$R, $In extends PilotIdInputState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, TerminalEndpoint,
          TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>>
      get endpointOptions;
  TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>?
      get selectedEndpoint;
  $R call(
      {List<TerminalEndpoint>? endpointOptions,
      TerminalEndpoint? selectedEndpoint});
  PilotIdInputStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PilotIdInputStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PilotIdInputState, $Out>
    implements PilotIdInputStateCopyWith<$R, PilotIdInputState, $Out> {
  _PilotIdInputStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PilotIdInputState> $mapper =
      PilotIdInputStateMapper.ensureInitialized();
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
  $R call(
          {List<TerminalEndpoint>? endpointOptions,
          Object? selectedEndpoint = $none}) =>
      $apply(FieldCopyWithData({
        if (endpointOptions != null) #endpointOptions: endpointOptions,
        if (selectedEndpoint != $none) #selectedEndpoint: selectedEndpoint
      }));
  @override
  PilotIdInputState $make(CopyWithData data) => PilotIdInputState(
      endpointOptions: data.get(#endpointOptions, or: $value.endpointOptions),
      selectedEndpoint:
          data.get(#selectedEndpoint, or: $value.selectedEndpoint));

  @override
  PilotIdInputStateCopyWith<$R2, PilotIdInputState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PilotIdInputStateCopyWithImpl($value, $cast, t);
}
