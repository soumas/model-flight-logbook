// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pilot_status.dart';

class PilotStatusMapper extends ClassMapperBase<PilotStatus> {
  PilotStatusMapper._();

  static PilotStatusMapper? _instance;
  static PilotStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PilotStatusMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PilotStatus';

  static String _$pilotName(PilotStatus v) => v.pilotName;
  static const Field<PilotStatus, String> _f$pilotName =
      Field('pilotName', _$pilotName);
  static int? _$sessionId(PilotStatus v) => v.sessionId;
  static const Field<PilotStatus, int> _f$sessionId =
      Field('sessionId', _$sessionId, opt: true);
  static String? _$sessionStarttime(PilotStatus v) => v.sessionStarttime;
  static const Field<PilotStatus, String> _f$sessionStarttime =
      Field('sessionStarttime', _$sessionStarttime, opt: true);
  static String? _$sessionEndtime(PilotStatus v) => v.sessionEndtime;
  static const Field<PilotStatus, String> _f$sessionEndtime =
      Field('sessionEndtime', _$sessionEndtime, opt: true);
  static String? _$flightPlanStatus(PilotStatus v) => v.flightPlanStatus;
  static const Field<PilotStatus, String> _f$flightPlanStatus =
      Field('flightPlanStatus', _$flightPlanStatus, opt: true);
  static List<String>? _$infoMessages(PilotStatus v) => v.infoMessages;
  static const Field<PilotStatus, List<String>> _f$infoMessages =
      Field('infoMessages', _$infoMessages, opt: true);
  static List<String>? _$warnMessages(PilotStatus v) => v.warnMessages;
  static const Field<PilotStatus, List<String>> _f$warnMessages =
      Field('warnMessages', _$warnMessages, opt: true);
  static List<String>? _$errorMessages(PilotStatus v) => v.errorMessages;
  static const Field<PilotStatus, List<String>> _f$errorMessages =
      Field('errorMessages', _$errorMessages, opt: true);

  @override
  final MappableFields<PilotStatus> fields = const {
    #pilotName: _f$pilotName,
    #sessionId: _f$sessionId,
    #sessionStarttime: _f$sessionStarttime,
    #sessionEndtime: _f$sessionEndtime,
    #flightPlanStatus: _f$flightPlanStatus,
    #infoMessages: _f$infoMessages,
    #warnMessages: _f$warnMessages,
    #errorMessages: _f$errorMessages,
  };

  static PilotStatus _instantiate(DecodingData data) {
    return PilotStatus(
        pilotName: data.dec(_f$pilotName),
        sessionId: data.dec(_f$sessionId),
        sessionStarttime: data.dec(_f$sessionStarttime),
        sessionEndtime: data.dec(_f$sessionEndtime),
        flightPlanStatus: data.dec(_f$flightPlanStatus),
        infoMessages: data.dec(_f$infoMessages),
        warnMessages: data.dec(_f$warnMessages),
        errorMessages: data.dec(_f$errorMessages));
  }

  @override
  final Function instantiate = _instantiate;

  static PilotStatus fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PilotStatus>(map);
  }

  static PilotStatus fromJson(String json) {
    return ensureInitialized().decodeJson<PilotStatus>(json);
  }
}

mixin PilotStatusMappable {
  String toJson() {
    return PilotStatusMapper.ensureInitialized()
        .encodeJson<PilotStatus>(this as PilotStatus);
  }

  Map<String, dynamic> toMap() {
    return PilotStatusMapper.ensureInitialized()
        .encodeMap<PilotStatus>(this as PilotStatus);
  }

  PilotStatusCopyWith<PilotStatus, PilotStatus, PilotStatus> get copyWith =>
      _PilotStatusCopyWithImpl(this as PilotStatus, $identity, $identity);
  @override
  String toString() {
    return PilotStatusMapper.ensureInitialized()
        .stringifyValue(this as PilotStatus);
  }

  @override
  bool operator ==(Object other) {
    return PilotStatusMapper.ensureInitialized()
        .equalsValue(this as PilotStatus, other);
  }

  @override
  int get hashCode {
    return PilotStatusMapper.ensureInitialized().hashValue(this as PilotStatus);
  }
}

extension PilotStatusValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PilotStatus, $Out> {
  PilotStatusCopyWith<$R, PilotStatus, $Out> get $asPilotStatus =>
      $base.as((v, t, t2) => _PilotStatusCopyWithImpl(v, t, t2));
}

abstract class PilotStatusCopyWith<$R, $In extends PilotStatus, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get infoMessages;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get warnMessages;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get errorMessages;
  $R call(
      {String? pilotName,
      int? sessionId,
      String? sessionStarttime,
      String? sessionEndtime,
      String? flightPlanStatus,
      List<String>? infoMessages,
      List<String>? warnMessages,
      List<String>? errorMessages});
  PilotStatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PilotStatusCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PilotStatus, $Out>
    implements PilotStatusCopyWith<$R, PilotStatus, $Out> {
  _PilotStatusCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PilotStatus> $mapper =
      PilotStatusMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get infoMessages => $value.infoMessages != null
          ? ListCopyWith(
              $value.infoMessages!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(infoMessages: v))
          : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get warnMessages => $value.warnMessages != null
          ? ListCopyWith(
              $value.warnMessages!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(warnMessages: v))
          : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get errorMessages => $value.errorMessages != null
          ? ListCopyWith(
              $value.errorMessages!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(errorMessages: v))
          : null;
  @override
  $R call(
          {String? pilotName,
          Object? sessionId = $none,
          Object? sessionStarttime = $none,
          Object? sessionEndtime = $none,
          Object? flightPlanStatus = $none,
          Object? infoMessages = $none,
          Object? warnMessages = $none,
          Object? errorMessages = $none}) =>
      $apply(FieldCopyWithData({
        if (pilotName != null) #pilotName: pilotName,
        if (sessionId != $none) #sessionId: sessionId,
        if (sessionStarttime != $none) #sessionStarttime: sessionStarttime,
        if (sessionEndtime != $none) #sessionEndtime: sessionEndtime,
        if (flightPlanStatus != $none) #flightPlanStatus: flightPlanStatus,
        if (infoMessages != $none) #infoMessages: infoMessages,
        if (warnMessages != $none) #warnMessages: warnMessages,
        if (errorMessages != $none) #errorMessages: errorMessages
      }));
  @override
  PilotStatus $make(CopyWithData data) => PilotStatus(
      pilotName: data.get(#pilotName, or: $value.pilotName),
      sessionId: data.get(#sessionId, or: $value.sessionId),
      sessionStarttime:
          data.get(#sessionStarttime, or: $value.sessionStarttime),
      sessionEndtime: data.get(#sessionEndtime, or: $value.sessionEndtime),
      flightPlanStatus:
          data.get(#flightPlanStatus, or: $value.flightPlanStatus),
      infoMessages: data.get(#infoMessages, or: $value.infoMessages),
      warnMessages: data.get(#warnMessages, or: $value.warnMessages),
      errorMessages: data.get(#errorMessages, or: $value.errorMessages));

  @override
  PilotStatusCopyWith<$R2, PilotStatus, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PilotStatusCopyWithImpl($value, $cast, t);
}
