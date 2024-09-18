// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pilotid_input_state.dart';

class PilotidInputStateMapper extends ClassMapperBase<PilotidInputState> {
  PilotidInputStateMapper._();

  static PilotidInputStateMapper? _instance;
  static PilotidInputStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PilotidInputStateMapper._());
      TerminalEndpointMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PilotidInputState';

  static List<TerminalEndpoint> _$endpointOptions(PilotidInputState v) =>
      v.endpointOptions;
  static const Field<PilotidInputState, List<TerminalEndpoint>>
      _f$endpointOptions =
      Field('endpointOptions', _$endpointOptions, opt: true, def: const []);
  static TerminalEndpoint? _$selectedEndpoint(PilotidInputState v) =>
      v.selectedEndpoint;
  static const Field<PilotidInputState, TerminalEndpoint> _f$selectedEndpoint =
      Field('selectedEndpoint', _$selectedEndpoint, opt: true);

  @override
  final MappableFields<PilotidInputState> fields = const {
    #endpointOptions: _f$endpointOptions,
    #selectedEndpoint: _f$selectedEndpoint,
  };

  static PilotidInputState _instantiate(DecodingData data) {
    return PilotidInputState(
        endpointOptions: data.dec(_f$endpointOptions),
        selectedEndpoint: data.dec(_f$selectedEndpoint));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin PilotidInputStateMappable {
  PilotidInputStateCopyWith<PilotidInputState, PilotidInputState,
          PilotidInputState>
      get copyWith => _PilotidInputStateCopyWithImpl(
          this as PilotidInputState, $identity, $identity);
  @override
  String toString() {
    return PilotidInputStateMapper.ensureInitialized()
        .stringifyValue(this as PilotidInputState);
  }

  @override
  bool operator ==(Object other) {
    return PilotidInputStateMapper.ensureInitialized()
        .equalsValue(this as PilotidInputState, other);
  }

  @override
  int get hashCode {
    return PilotidInputStateMapper.ensureInitialized()
        .hashValue(this as PilotidInputState);
  }
}

extension PilotidInputStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PilotidInputState, $Out> {
  PilotidInputStateCopyWith<$R, PilotidInputState, $Out>
      get $asPilotidInputState =>
          $base.as((v, t, t2) => _PilotidInputStateCopyWithImpl(v, t, t2));
}

abstract class PilotidInputStateCopyWith<$R, $In extends PilotidInputState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, TerminalEndpoint,
          TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>>
      get endpointOptions;
  TerminalEndpointCopyWith<$R, TerminalEndpoint, TerminalEndpoint>?
      get selectedEndpoint;
  $R call(
      {List<TerminalEndpoint>? endpointOptions,
      TerminalEndpoint? selectedEndpoint});
  PilotidInputStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PilotidInputStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PilotidInputState, $Out>
    implements PilotidInputStateCopyWith<$R, PilotidInputState, $Out> {
  _PilotidInputStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PilotidInputState> $mapper =
      PilotidInputStateMapper.ensureInitialized();
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
  PilotidInputState $make(CopyWithData data) => PilotidInputState(
      endpointOptions: data.get(#endpointOptions, or: $value.endpointOptions),
      selectedEndpoint:
          data.get(#selectedEndpoint, or: $value.selectedEndpoint));

  @override
  PilotidInputStateCopyWith<$R2, PilotidInputState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PilotidInputStateCopyWithImpl($value, $cast, t);
}
