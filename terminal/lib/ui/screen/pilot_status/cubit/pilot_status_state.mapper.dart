// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
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
  static const Field<PilotStatusState, bool> _f$loading = Field(
    'loading',
    _$loading,
    opt: true,
    def: false,
  );
  static String _$pilotid(PilotStatusState v) => v.pilotid;
  static const Field<PilotStatusState, String> _f$pilotid = Field(
    'pilotid',
    _$pilotid,
    opt: true,
    def: '',
  );
  static PilotStatus? _$flightSessionStatus(PilotStatusState v) =>
      v.flightSessionStatus;
  static const Field<PilotStatusState, PilotStatus> _f$flightSessionStatus =
      Field('flightSessionStatus', _$flightSessionStatus, opt: true);
  static String? _$completedAction(PilotStatusState v) => v.completedAction;
  static const Field<PilotStatusState, String> _f$completedAction = Field(
    'completedAction',
    _$completedAction,
    opt: true,
  );

  @override
  final MappableFields<PilotStatusState> fields = const {
    #loading: _f$loading,
    #pilotid: _f$pilotid,
    #flightSessionStatus: _f$flightSessionStatus,
    #completedAction: _f$completedAction,
  };

  static PilotStatusState _instantiate(DecodingData data) {
    return PilotStatusState(
      loading: data.dec(_f$loading),
      pilotid: data.dec(_f$pilotid),
      flightSessionStatus: data.dec(_f$flightSessionStatus),
      completedAction: data.dec(_f$completedAction),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin PilotStatusStateMappable {
  PilotStatusStateCopyWith<PilotStatusState, PilotStatusState, PilotStatusState>
  get copyWith =>
      _PilotStatusStateCopyWithImpl<PilotStatusState, PilotStatusState>(
        this as PilotStatusState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PilotStatusStateMapper.ensureInitialized().stringifyValue(
      this as PilotStatusState,
    );
  }

  @override
  bool operator ==(Object other) {
    return PilotStatusStateMapper.ensureInitialized().equalsValue(
      this as PilotStatusState,
      other,
    );
  }

  @override
  int get hashCode {
    return PilotStatusStateMapper.ensureInitialized().hashValue(
      this as PilotStatusState,
    );
  }
}

extension PilotStatusStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PilotStatusState, $Out> {
  PilotStatusStateCopyWith<$R, PilotStatusState, $Out>
  get $asPilotStatusState =>
      $base.as((v, t, t2) => _PilotStatusStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PilotStatusStateCopyWith<$R, $In extends PilotStatusState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PilotStatusCopyWith<$R, PilotStatus, PilotStatus>? get flightSessionStatus;
  $R call({
    bool? loading,
    String? pilotid,
    PilotStatus? flightSessionStatus,
    String? completedAction,
  });
  PilotStatusStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
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
      $value.flightSessionStatus?.copyWith.$chain(
        (v) => call(flightSessionStatus: v),
      );
  @override
  $R call({
    bool? loading,
    String? pilotid,
    Object? flightSessionStatus = $none,
    Object? completedAction = $none,
  }) => $apply(
    FieldCopyWithData({
      if (loading != null) #loading: loading,
      if (pilotid != null) #pilotid: pilotid,
      if (flightSessionStatus != $none)
        #flightSessionStatus: flightSessionStatus,
      if (completedAction != $none) #completedAction: completedAction,
    }),
  );
  @override
  PilotStatusState $make(CopyWithData data) => PilotStatusState(
    loading: data.get(#loading, or: $value.loading),
    pilotid: data.get(#pilotid, or: $value.pilotid),
    flightSessionStatus: data.get(
      #flightSessionStatus,
      or: $value.flightSessionStatus,
    ),
    completedAction: data.get(#completedAction, or: $value.completedAction),
  );

  @override
  PilotStatusStateCopyWith<$R2, PilotStatusState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PilotStatusStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

