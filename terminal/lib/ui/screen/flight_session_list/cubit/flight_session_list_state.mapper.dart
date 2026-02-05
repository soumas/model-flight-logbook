// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'flight_session_list_state.dart';

class FlightSessionListStateMapper
    extends ClassMapperBase<FlightSessionListState> {
  FlightSessionListStateMapper._();

  static FlightSessionListStateMapper? _instance;
  static FlightSessionListStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlightSessionListStateMapper._());
      FlightSessionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FlightSessionListState';

  static bool _$loading(FlightSessionListState v) => v.loading;
  static const Field<FlightSessionListState, bool> _f$loading = Field(
    'loading',
    _$loading,
    opt: true,
    def: false,
  );
  static List<FlightSession> _$flightSessions(FlightSessionListState v) =>
      v.flightSessions;
  static const Field<FlightSessionListState, List<FlightSession>>
  _f$flightSessions = Field(
    'flightSessions',
    _$flightSessions,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<FlightSessionListState> fields = const {
    #loading: _f$loading,
    #flightSessions: _f$flightSessions,
  };

  static FlightSessionListState _instantiate(DecodingData data) {
    return FlightSessionListState(
      loading: data.dec(_f$loading),
      flightSessions: data.dec(_f$flightSessions),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin FlightSessionListStateMappable {
  FlightSessionListStateCopyWith<
    FlightSessionListState,
    FlightSessionListState,
    FlightSessionListState
  >
  get copyWith =>
      _FlightSessionListStateCopyWithImpl<
        FlightSessionListState,
        FlightSessionListState
      >(this as FlightSessionListState, $identity, $identity);
  @override
  String toString() {
    return FlightSessionListStateMapper.ensureInitialized().stringifyValue(
      this as FlightSessionListState,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlightSessionListStateMapper.ensureInitialized().equalsValue(
      this as FlightSessionListState,
      other,
    );
  }

  @override
  int get hashCode {
    return FlightSessionListStateMapper.ensureInitialized().hashValue(
      this as FlightSessionListState,
    );
  }
}

extension FlightSessionListStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlightSessionListState, $Out> {
  FlightSessionListStateCopyWith<$R, FlightSessionListState, $Out>
  get $asFlightSessionListState => $base.as(
    (v, t, t2) => _FlightSessionListStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FlightSessionListStateCopyWith<
  $R,
  $In extends FlightSessionListState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    FlightSession,
    FlightSessionCopyWith<$R, FlightSession, FlightSession>
  >
  get flightSessions;
  $R call({bool? loading, List<FlightSession>? flightSessions});
  FlightSessionListStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FlightSessionListStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlightSessionListState, $Out>
    implements
        FlightSessionListStateCopyWith<$R, FlightSessionListState, $Out> {
  _FlightSessionListStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlightSessionListState> $mapper =
      FlightSessionListStateMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    FlightSession,
    FlightSessionCopyWith<$R, FlightSession, FlightSession>
  >
  get flightSessions => ListCopyWith(
    $value.flightSessions,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(flightSessions: v),
  );
  @override
  $R call({bool? loading, List<FlightSession>? flightSessions}) => $apply(
    FieldCopyWithData({
      if (loading != null) #loading: loading,
      if (flightSessions != null) #flightSessions: flightSessions,
    }),
  );
  @override
  FlightSessionListState $make(CopyWithData data) => FlightSessionListState(
    loading: data.get(#loading, or: $value.loading),
    flightSessions: data.get(#flightSessions, or: $value.flightSessions),
  );

  @override
  FlightSessionListStateCopyWith<$R2, FlightSessionListState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FlightSessionListStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

