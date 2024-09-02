// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'flight_session_status_state.dart';

class FlightSessionStatusStateMapper
    extends ClassMapperBase<FlightSessionStatusState> {
  FlightSessionStatusStateMapper._();

  static FlightSessionStatusStateMapper? _instance;
  static FlightSessionStatusStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = FlightSessionStatusStateMapper._());
      FlightSessionStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FlightSessionStatusState';

  static bool _$loading(FlightSessionStatusState v) => v.loading;
  static const Field<FlightSessionStatusState, bool> _f$loading =
      Field('loading', _$loading, opt: true, def: false);
  static String _$pilotid(FlightSessionStatusState v) => v.pilotid;
  static const Field<FlightSessionStatusState, String> _f$pilotid =
      Field('pilotid', _$pilotid, opt: true, def: '');
  static FlightSessionStatus? _$flightSessionStatus(
          FlightSessionStatusState v) =>
      v.flightSessionStatus;
  static const Field<FlightSessionStatusState, FlightSessionStatus>
      _f$flightSessionStatus =
      Field('flightSessionStatus', _$flightSessionStatus, opt: true);
  static dynamic _$error(FlightSessionStatusState v) => v.error;
  static const Field<FlightSessionStatusState, dynamic> _f$error =
      Field('error', _$error, opt: true);
  static String? _$completedAction(FlightSessionStatusState v) =>
      v.completedAction;
  static const Field<FlightSessionStatusState, String> _f$completedAction =
      Field('completedAction', _$completedAction, opt: true);

  @override
  final MappableFields<FlightSessionStatusState> fields = const {
    #loading: _f$loading,
    #pilotid: _f$pilotid,
    #flightSessionStatus: _f$flightSessionStatus,
    #error: _f$error,
    #completedAction: _f$completedAction,
  };

  static FlightSessionStatusState _instantiate(DecodingData data) {
    return FlightSessionStatusState(
        loading: data.dec(_f$loading),
        pilotid: data.dec(_f$pilotid),
        flightSessionStatus: data.dec(_f$flightSessionStatus),
        error: data.dec(_f$error),
        completedAction: data.dec(_f$completedAction));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin FlightSessionStatusStateMappable {
  FlightSessionStatusStateCopyWith<FlightSessionStatusState,
          FlightSessionStatusState, FlightSessionStatusState>
      get copyWith => _FlightSessionStatusStateCopyWithImpl(
          this as FlightSessionStatusState, $identity, $identity);
  @override
  String toString() {
    return FlightSessionStatusStateMapper.ensureInitialized()
        .stringifyValue(this as FlightSessionStatusState);
  }

  @override
  bool operator ==(Object other) {
    return FlightSessionStatusStateMapper.ensureInitialized()
        .equalsValue(this as FlightSessionStatusState, other);
  }

  @override
  int get hashCode {
    return FlightSessionStatusStateMapper.ensureInitialized()
        .hashValue(this as FlightSessionStatusState);
  }
}

extension FlightSessionStatusStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlightSessionStatusState, $Out> {
  FlightSessionStatusStateCopyWith<$R, FlightSessionStatusState, $Out>
      get $asFlightSessionStatusState => $base
          .as((v, t, t2) => _FlightSessionStatusStateCopyWithImpl(v, t, t2));
}

abstract class FlightSessionStatusStateCopyWith<
    $R,
    $In extends FlightSessionStatusState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  FlightSessionStatusCopyWith<$R, FlightSessionStatus, FlightSessionStatus>?
      get flightSessionStatus;
  $R call(
      {bool? loading,
      String? pilotid,
      FlightSessionStatus? flightSessionStatus,
      dynamic error,
      String? completedAction});
  FlightSessionStatusStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FlightSessionStatusStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlightSessionStatusState, $Out>
    implements
        FlightSessionStatusStateCopyWith<$R, FlightSessionStatusState, $Out> {
  _FlightSessionStatusStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlightSessionStatusState> $mapper =
      FlightSessionStatusStateMapper.ensureInitialized();
  @override
  FlightSessionStatusCopyWith<$R, FlightSessionStatus, FlightSessionStatus>?
      get flightSessionStatus => $value.flightSessionStatus?.copyWith
          .$chain((v) => call(flightSessionStatus: v));
  @override
  $R call(
          {bool? loading,
          String? pilotid,
          Object? flightSessionStatus = $none,
          Object? error = $none,
          Object? completedAction = $none}) =>
      $apply(FieldCopyWithData({
        if (loading != null) #loading: loading,
        if (pilotid != null) #pilotid: pilotid,
        if (flightSessionStatus != $none)
          #flightSessionStatus: flightSessionStatus,
        if (error != $none) #error: error,
        if (completedAction != $none) #completedAction: completedAction
      }));
  @override
  FlightSessionStatusState $make(CopyWithData data) => FlightSessionStatusState(
      loading: data.get(#loading, or: $value.loading),
      pilotid: data.get(#pilotid, or: $value.pilotid),
      flightSessionStatus:
          data.get(#flightSessionStatus, or: $value.flightSessionStatus),
      error: data.get(#error, or: $value.error),
      completedAction: data.get(#completedAction, or: $value.completedAction));

  @override
  FlightSessionStatusStateCopyWith<$R2, FlightSessionStatusState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _FlightSessionStatusStateCopyWithImpl($value, $cast, t);
}
