// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'flight_session.dart';

class FlightSessionMapper extends ClassMapperBase<FlightSession> {
  FlightSessionMapper._();

  static FlightSessionMapper? _instance;
  static FlightSessionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlightSessionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FlightSession';

  static int _$id(FlightSession v) => v.id;
  static const Field<FlightSession, int> _f$id = Field('id', _$id);
  static String _$pilotid(FlightSession v) => v.pilotid;
  static const Field<FlightSession, String> _f$pilotid = Field(
    'pilotid',
    _$pilotid,
  );
  static String _$terminalid(FlightSession v) => v.terminalid;
  static const Field<FlightSession, String> _f$terminalid = Field(
    'terminalid',
    _$terminalid,
  );
  static DateTime _$start(FlightSession v) => v.start;
  static const Field<FlightSession, DateTime> _f$start = Field(
    'start',
    _$start,
  );
  static DateTime? _$end(FlightSession v) => v.end;
  static const Field<FlightSession, DateTime> _f$end = Field(
    'end',
    _$end,
    opt: true,
  );
  static int? _$takeoffcount(FlightSession v) => v.takeoffcount;
  static const Field<FlightSession, int> _f$takeoffcount = Field(
    'takeoffcount',
    _$takeoffcount,
    opt: true,
  );
  static int? _$maxAltitude(FlightSession v) => v.maxAltitude;
  static const Field<FlightSession, int> _f$maxAltitude = Field(
    'maxAltitude',
    _$maxAltitude,
    opt: true,
  );
  static bool? _$airspaceObserver(FlightSession v) => v.airspaceObserver;
  static const Field<FlightSession, bool> _f$airspaceObserver = Field(
    'airspaceObserver',
    _$airspaceObserver,
    opt: true,
  );
  static String? _$comment(FlightSession v) => v.comment;
  static const Field<FlightSession, String> _f$comment = Field(
    'comment',
    _$comment,
    opt: true,
  );
  static String? _$pilotname(FlightSession v) => v.pilotname;
  static const Field<FlightSession, String> _f$pilotname = Field(
    'pilotname',
    _$pilotname,
    opt: true,
  );
  static String? _$airport(FlightSession v) => v.airport;
  static const Field<FlightSession, String> _f$airport = Field(
    'airport',
    _$airport,
    opt: true,
  );
  static String? _$endedby(FlightSession v) => v.endedby;
  static const Field<FlightSession, String> _f$endedby = Field(
    'endedby',
    _$endedby,
    opt: true,
  );

  @override
  final MappableFields<FlightSession> fields = const {
    #id: _f$id,
    #pilotid: _f$pilotid,
    #terminalid: _f$terminalid,
    #start: _f$start,
    #end: _f$end,
    #takeoffcount: _f$takeoffcount,
    #maxAltitude: _f$maxAltitude,
    #airspaceObserver: _f$airspaceObserver,
    #comment: _f$comment,
    #pilotname: _f$pilotname,
    #airport: _f$airport,
    #endedby: _f$endedby,
  };

  static FlightSession _instantiate(DecodingData data) {
    return FlightSession(
      id: data.dec(_f$id),
      pilotid: data.dec(_f$pilotid),
      terminalid: data.dec(_f$terminalid),
      start: data.dec(_f$start),
      end: data.dec(_f$end),
      takeoffcount: data.dec(_f$takeoffcount),
      maxAltitude: data.dec(_f$maxAltitude),
      airspaceObserver: data.dec(_f$airspaceObserver),
      comment: data.dec(_f$comment),
      pilotname: data.dec(_f$pilotname),
      airport: data.dec(_f$airport),
      endedby: data.dec(_f$endedby),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FlightSession fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlightSession>(map);
  }

  static FlightSession fromJson(String json) {
    return ensureInitialized().decodeJson<FlightSession>(json);
  }
}

mixin FlightSessionMappable {
  String toJson() {
    return FlightSessionMapper.ensureInitialized().encodeJson<FlightSession>(
      this as FlightSession,
    );
  }

  Map<String, dynamic> toMap() {
    return FlightSessionMapper.ensureInitialized().encodeMap<FlightSession>(
      this as FlightSession,
    );
  }

  FlightSessionCopyWith<FlightSession, FlightSession, FlightSession>
  get copyWith => _FlightSessionCopyWithImpl<FlightSession, FlightSession>(
    this as FlightSession,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return FlightSessionMapper.ensureInitialized().stringifyValue(
      this as FlightSession,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlightSessionMapper.ensureInitialized().equalsValue(
      this as FlightSession,
      other,
    );
  }

  @override
  int get hashCode {
    return FlightSessionMapper.ensureInitialized().hashValue(
      this as FlightSession,
    );
  }
}

extension FlightSessionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlightSession, $Out> {
  FlightSessionCopyWith<$R, FlightSession, $Out> get $asFlightSession =>
      $base.as((v, t, t2) => _FlightSessionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FlightSessionCopyWith<$R, $In extends FlightSession, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    String? pilotid,
    String? terminalid,
    DateTime? start,
    DateTime? end,
    int? takeoffcount,
    int? maxAltitude,
    bool? airspaceObserver,
    String? comment,
    String? pilotname,
    String? airport,
    String? endedby,
  });
  FlightSessionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FlightSessionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlightSession, $Out>
    implements FlightSessionCopyWith<$R, FlightSession, $Out> {
  _FlightSessionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlightSession> $mapper =
      FlightSessionMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    String? pilotid,
    String? terminalid,
    DateTime? start,
    Object? end = $none,
    Object? takeoffcount = $none,
    Object? maxAltitude = $none,
    Object? airspaceObserver = $none,
    Object? comment = $none,
    Object? pilotname = $none,
    Object? airport = $none,
    Object? endedby = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (pilotid != null) #pilotid: pilotid,
      if (terminalid != null) #terminalid: terminalid,
      if (start != null) #start: start,
      if (end != $none) #end: end,
      if (takeoffcount != $none) #takeoffcount: takeoffcount,
      if (maxAltitude != $none) #maxAltitude: maxAltitude,
      if (airspaceObserver != $none) #airspaceObserver: airspaceObserver,
      if (comment != $none) #comment: comment,
      if (pilotname != $none) #pilotname: pilotname,
      if (airport != $none) #airport: airport,
      if (endedby != $none) #endedby: endedby,
    }),
  );
  @override
  FlightSession $make(CopyWithData data) => FlightSession(
    id: data.get(#id, or: $value.id),
    pilotid: data.get(#pilotid, or: $value.pilotid),
    terminalid: data.get(#terminalid, or: $value.terminalid),
    start: data.get(#start, or: $value.start),
    end: data.get(#end, or: $value.end),
    takeoffcount: data.get(#takeoffcount, or: $value.takeoffcount),
    maxAltitude: data.get(#maxAltitude, or: $value.maxAltitude),
    airspaceObserver: data.get(#airspaceObserver, or: $value.airspaceObserver),
    comment: data.get(#comment, or: $value.comment),
    pilotname: data.get(#pilotname, or: $value.pilotname),
    airport: data.get(#airport, or: $value.airport),
    endedby: data.get(#endedby, or: $value.endedby),
  );

  @override
  FlightSessionCopyWith<$R2, FlightSession, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FlightSessionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

