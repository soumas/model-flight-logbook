// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'flight_session_status.dart';

class FlightSessionStatusMapper extends ClassMapperBase<FlightSessionStatus> {
  FlightSessionStatusMapper._();

  static FlightSessionStatusMapper? _instance;
  static FlightSessionStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlightSessionStatusMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FlightSessionStatus';

  static String _$pilotName(FlightSessionStatus v) => v.pilotName;
  static const Field<FlightSessionStatus, String> _f$pilotName =
      Field('pilotName', _$pilotName);
  static int? _$sessionId(FlightSessionStatus v) => v.sessionId;
  static const Field<FlightSessionStatus, int> _f$sessionId =
      Field('sessionId', _$sessionId, opt: true);
  static String? _$sessionStarttime(FlightSessionStatus v) =>
      v.sessionStarttime;
  static const Field<FlightSessionStatus, String> _f$sessionStarttime =
      Field('sessionStarttime', _$sessionStarttime, opt: true);
  static String? _$sessionEndtime(FlightSessionStatus v) => v.sessionEndtime;
  static const Field<FlightSessionStatus, String> _f$sessionEndtime =
      Field('sessionEndtime', _$sessionEndtime, opt: true);
  static String? _$flightPlanStatus(FlightSessionStatus v) =>
      v.flightPlanStatus;
  static const Field<FlightSessionStatus, String> _f$flightPlanStatus =
      Field('flightPlanStatus', _$flightPlanStatus, opt: true);

  @override
  final MappableFields<FlightSessionStatus> fields = const {
    #pilotName: _f$pilotName,
    #sessionId: _f$sessionId,
    #sessionStarttime: _f$sessionStarttime,
    #sessionEndtime: _f$sessionEndtime,
    #flightPlanStatus: _f$flightPlanStatus,
  };

  static FlightSessionStatus _instantiate(DecodingData data) {
    return FlightSessionStatus(
        pilotName: data.dec(_f$pilotName),
        sessionId: data.dec(_f$sessionId),
        sessionStarttime: data.dec(_f$sessionStarttime),
        sessionEndtime: data.dec(_f$sessionEndtime),
        flightPlanStatus: data.dec(_f$flightPlanStatus));
  }

  @override
  final Function instantiate = _instantiate;

  static FlightSessionStatus fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlightSessionStatus>(map);
  }

  static FlightSessionStatus fromJson(String json) {
    return ensureInitialized().decodeJson<FlightSessionStatus>(json);
  }
}

mixin FlightSessionStatusMappable {
  String toJson() {
    return FlightSessionStatusMapper.ensureInitialized()
        .encodeJson<FlightSessionStatus>(this as FlightSessionStatus);
  }

  Map<String, dynamic> toMap() {
    return FlightSessionStatusMapper.ensureInitialized()
        .encodeMap<FlightSessionStatus>(this as FlightSessionStatus);
  }

  FlightSessionStatusCopyWith<FlightSessionStatus, FlightSessionStatus,
          FlightSessionStatus>
      get copyWith => _FlightSessionStatusCopyWithImpl(
          this as FlightSessionStatus, $identity, $identity);
  @override
  String toString() {
    return FlightSessionStatusMapper.ensureInitialized()
        .stringifyValue(this as FlightSessionStatus);
  }

  @override
  bool operator ==(Object other) {
    return FlightSessionStatusMapper.ensureInitialized()
        .equalsValue(this as FlightSessionStatus, other);
  }

  @override
  int get hashCode {
    return FlightSessionStatusMapper.ensureInitialized()
        .hashValue(this as FlightSessionStatus);
  }
}

extension FlightSessionStatusValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlightSessionStatus, $Out> {
  FlightSessionStatusCopyWith<$R, FlightSessionStatus, $Out>
      get $asFlightSessionStatus =>
          $base.as((v, t, t2) => _FlightSessionStatusCopyWithImpl(v, t, t2));
}

abstract class FlightSessionStatusCopyWith<$R, $In extends FlightSessionStatus,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? pilotName,
      int? sessionId,
      String? sessionStarttime,
      String? sessionEndtime,
      String? flightPlanStatus});
  FlightSessionStatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FlightSessionStatusCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlightSessionStatus, $Out>
    implements FlightSessionStatusCopyWith<$R, FlightSessionStatus, $Out> {
  _FlightSessionStatusCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlightSessionStatus> $mapper =
      FlightSessionStatusMapper.ensureInitialized();
  @override
  $R call(
          {String? pilotName,
          Object? sessionId = $none,
          Object? sessionStarttime = $none,
          Object? sessionEndtime = $none,
          Object? flightPlanStatus = $none}) =>
      $apply(FieldCopyWithData({
        if (pilotName != null) #pilotName: pilotName,
        if (sessionId != $none) #sessionId: sessionId,
        if (sessionStarttime != $none) #sessionStarttime: sessionStarttime,
        if (sessionEndtime != $none) #sessionEndtime: sessionEndtime,
        if (flightPlanStatus != $none) #flightPlanStatus: flightPlanStatus
      }));
  @override
  FlightSessionStatus $make(CopyWithData data) => FlightSessionStatus(
      pilotName: data.get(#pilotName, or: $value.pilotName),
      sessionId: data.get(#sessionId, or: $value.sessionId),
      sessionStarttime:
          data.get(#sessionStarttime, or: $value.sessionStarttime),
      sessionEndtime: data.get(#sessionEndtime, or: $value.sessionEndtime),
      flightPlanStatus:
          data.get(#flightPlanStatus, or: $value.flightPlanStatus));

  @override
  FlightSessionStatusCopyWith<$R2, FlightSessionStatus, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _FlightSessionStatusCopyWithImpl($value, $cast, t);
}
