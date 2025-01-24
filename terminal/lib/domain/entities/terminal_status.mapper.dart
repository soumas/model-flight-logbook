// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'terminal_status.dart';

class TerminalStatusMapper extends ClassMapperBase<TerminalStatus> {
  TerminalStatusMapper._();

  static TerminalStatusMapper? _instance;
  static TerminalStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TerminalStatusMapper._());
      UtmSyncStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TerminalStatus';

  static UtmSyncStatus _$utmStatus(TerminalStatus v) => v.utmStatus;
  static const Field<TerminalStatus, UtmSyncStatus> _f$utmStatus =
      Field('utmStatus', _$utmStatus);

  @override
  final MappableFields<TerminalStatus> fields = const {
    #utmStatus: _f$utmStatus,
  };

  static TerminalStatus _instantiate(DecodingData data) {
    return TerminalStatus(utmStatus: data.dec(_f$utmStatus));
  }

  @override
  final Function instantiate = _instantiate;

  static TerminalStatus fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TerminalStatus>(map);
  }

  static TerminalStatus fromJson(String json) {
    return ensureInitialized().decodeJson<TerminalStatus>(json);
  }
}

mixin TerminalStatusMappable {
  String toJson() {
    return TerminalStatusMapper.ensureInitialized()
        .encodeJson<TerminalStatus>(this as TerminalStatus);
  }

  Map<String, dynamic> toMap() {
    return TerminalStatusMapper.ensureInitialized()
        .encodeMap<TerminalStatus>(this as TerminalStatus);
  }

  TerminalStatusCopyWith<TerminalStatus, TerminalStatus, TerminalStatus>
      get copyWith => _TerminalStatusCopyWithImpl(
          this as TerminalStatus, $identity, $identity);
  @override
  String toString() {
    return TerminalStatusMapper.ensureInitialized()
        .stringifyValue(this as TerminalStatus);
  }

  @override
  bool operator ==(Object other) {
    return TerminalStatusMapper.ensureInitialized()
        .equalsValue(this as TerminalStatus, other);
  }

  @override
  int get hashCode {
    return TerminalStatusMapper.ensureInitialized()
        .hashValue(this as TerminalStatus);
  }
}

extension TerminalStatusValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TerminalStatus, $Out> {
  TerminalStatusCopyWith<$R, TerminalStatus, $Out> get $asTerminalStatus =>
      $base.as((v, t, t2) => _TerminalStatusCopyWithImpl(v, t, t2));
}

abstract class TerminalStatusCopyWith<$R, $In extends TerminalStatus, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({UtmSyncStatus? utmStatus});
  TerminalStatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TerminalStatusCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TerminalStatus, $Out>
    implements TerminalStatusCopyWith<$R, TerminalStatus, $Out> {
  _TerminalStatusCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TerminalStatus> $mapper =
      TerminalStatusMapper.ensureInitialized();
  @override
  $R call({UtmSyncStatus? utmStatus}) =>
      $apply(FieldCopyWithData({if (utmStatus != null) #utmStatus: utmStatus}));
  @override
  TerminalStatus $make(CopyWithData data) =>
      TerminalStatus(utmStatus: data.get(#utmStatus, or: $value.utmStatus));

  @override
  TerminalStatusCopyWith<$R2, TerminalStatus, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TerminalStatusCopyWithImpl($value, $cast, t);
}
