// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pilot_status_state.dart';

class PilotStatusStateMapper extends ClassMapperBase<PilotStatusState> {
  PilotStatusStateMapper._();

  static PilotStatusStateMapper? _instance;
  static PilotStatusStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PilotStatusStateMapper._());
      PilotStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PilotStatusState';

  static bool _$loading(PilotStatusState v) => v.loading;
  static const Field<PilotStatusState, bool> _f$loading =
      Field('loading', _$loading, opt: true, def: false);
  static String _$pilotid(PilotStatusState v) => v.pilotid;
  static const Field<PilotStatusState, String> _f$pilotid =
      Field('pilotid', _$pilotid, opt: true, def: '');
  static PilotStatus? _$flightSessionStatus(PilotStatusState v) =>
      v.flightSessionStatus;
  static const Field<PilotStatusState, PilotStatus> _f$flightSessionStatus =
      Field('flightSessionStatus', _$flightSessionStatus, opt: true);
  static String? _$completedAction(PilotStatusState v) => v.completedAction;
  static const Field<PilotStatusState, String> _f$completedAction =
      Field('completedAction', _$completedAction, opt: true);
  static List<String>? _$infoMessages(PilotStatusState v) => v.infoMessages;
  static const Field<PilotStatusState, List<String>> _f$infoMessages =
      Field('infoMessages', _$infoMessages, opt: true);
  static List<String>? _$warnMessages(PilotStatusState v) => v.warnMessages;
  static const Field<PilotStatusState, List<String>> _f$warnMessages =
      Field('warnMessages', _$warnMessages, opt: true);
  static List<String>? _$errorMessages(PilotStatusState v) => v.errorMessages;
  static const Field<PilotStatusState, List<String>> _f$errorMessages =
      Field('errorMessages', _$errorMessages, opt: true);

  @override
  final MappableFields<PilotStatusState> fields = const {
    #loading: _f$loading,
    #pilotid: _f$pilotid,
    #flightSessionStatus: _f$flightSessionStatus,
    #completedAction: _f$completedAction,
    #infoMessages: _f$infoMessages,
    #warnMessages: _f$warnMessages,
    #errorMessages: _f$errorMessages,
  };

  static PilotStatusState _instantiate(DecodingData data) {
    return PilotStatusState(
        loading: data.dec(_f$loading),
        pilotid: data.dec(_f$pilotid),
        flightSessionStatus: data.dec(_f$flightSessionStatus),
        completedAction: data.dec(_f$completedAction),
        infoMessages: data.dec(_f$infoMessages),
        warnMessages: data.dec(_f$warnMessages),
        errorMessages: data.dec(_f$errorMessages));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin PilotStatusStateMappable {
  PilotStatusStateCopyWith<PilotStatusState, PilotStatusState, PilotStatusState>
      get copyWith => _PilotStatusStateCopyWithImpl(
          this as PilotStatusState, $identity, $identity);
  @override
  String toString() {
    return PilotStatusStateMapper.ensureInitialized()
        .stringifyValue(this as PilotStatusState);
  }

  @override
  bool operator ==(Object other) {
    return PilotStatusStateMapper.ensureInitialized()
        .equalsValue(this as PilotStatusState, other);
  }

  @override
  int get hashCode {
    return PilotStatusStateMapper.ensureInitialized()
        .hashValue(this as PilotStatusState);
  }
}

extension PilotStatusStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PilotStatusState, $Out> {
  PilotStatusStateCopyWith<$R, PilotStatusState, $Out>
      get $asPilotStatusState =>
          $base.as((v, t, t2) => _PilotStatusStateCopyWithImpl(v, t, t2));
}

abstract class PilotStatusStateCopyWith<$R, $In extends PilotStatusState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PilotStatusCopyWith<$R, PilotStatus, PilotStatus>? get flightSessionStatus;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get infoMessages;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get warnMessages;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get errorMessages;
  $R call(
      {bool? loading,
      String? pilotid,
      PilotStatus? flightSessionStatus,
      String? completedAction,
      List<String>? infoMessages,
      List<String>? warnMessages,
      List<String>? errorMessages});
  PilotStatusStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PilotStatusStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PilotStatusState, $Out>
    implements PilotStatusStateCopyWith<$R, PilotStatusState, $Out> {
  _PilotStatusStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PilotStatusState> $mapper =
      PilotStatusStateMapper.ensureInitialized();
  @override
  PilotStatusCopyWith<$R, PilotStatus, PilotStatus>? get flightSessionStatus =>
      $value.flightSessionStatus?.copyWith
          .$chain((v) => call(flightSessionStatus: v));
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
          {bool? loading,
          String? pilotid,
          Object? flightSessionStatus = $none,
          Object? completedAction = $none,
          Object? infoMessages = $none,
          Object? warnMessages = $none,
          Object? errorMessages = $none}) =>
      $apply(FieldCopyWithData({
        if (loading != null) #loading: loading,
        if (pilotid != null) #pilotid: pilotid,
        if (flightSessionStatus != $none)
          #flightSessionStatus: flightSessionStatus,
        if (completedAction != $none) #completedAction: completedAction,
        if (infoMessages != $none) #infoMessages: infoMessages,
        if (warnMessages != $none) #warnMessages: warnMessages,
        if (errorMessages != $none) #errorMessages: errorMessages
      }));
  @override
  PilotStatusState $make(CopyWithData data) => PilotStatusState(
      loading: data.get(#loading, or: $value.loading),
      pilotid: data.get(#pilotid, or: $value.pilotid),
      flightSessionStatus:
          data.get(#flightSessionStatus, or: $value.flightSessionStatus),
      completedAction: data.get(#completedAction, or: $value.completedAction),
      infoMessages: data.get(#infoMessages, or: $value.infoMessages),
      warnMessages: data.get(#warnMessages, or: $value.warnMessages),
      errorMessages: data.get(#errorMessages, or: $value.errorMessages));

  @override
  PilotStatusStateCopyWith<$R2, PilotStatusState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PilotStatusStateCopyWithImpl($value, $cast, t);
}
