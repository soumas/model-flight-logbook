// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'utm_status.dart';

class UtmStatusMapper extends ClassMapperBase<UtmStatus> {
  UtmStatusMapper._();

  static UtmStatusMapper? _instance;
  static UtmStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UtmStatusMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UtmStatus';

  static String _$utmStatus(UtmStatus v) => v.utmStatus;
  static const Field<UtmStatus, String> _f$utmStatus =
      Field('utmStatus', _$utmStatus);

  @override
  final MappableFields<UtmStatus> fields = const {
    #utmStatus: _f$utmStatus,
  };

  static UtmStatus _instantiate(DecodingData data) {
    return UtmStatus(utmStatus: data.dec(_f$utmStatus));
  }

  @override
  final Function instantiate = _instantiate;

  static UtmStatus fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UtmStatus>(map);
  }

  static UtmStatus fromJson(String json) {
    return ensureInitialized().decodeJson<UtmStatus>(json);
  }
}

mixin UtmStatusMappable {
  String toJson() {
    return UtmStatusMapper.ensureInitialized()
        .encodeJson<UtmStatus>(this as UtmStatus);
  }

  Map<String, dynamic> toMap() {
    return UtmStatusMapper.ensureInitialized()
        .encodeMap<UtmStatus>(this as UtmStatus);
  }

  UtmStatusCopyWith<UtmStatus, UtmStatus, UtmStatus> get copyWith =>
      _UtmStatusCopyWithImpl(this as UtmStatus, $identity, $identity);
  @override
  String toString() {
    return UtmStatusMapper.ensureInitialized()
        .stringifyValue(this as UtmStatus);
  }

  @override
  bool operator ==(Object other) {
    return UtmStatusMapper.ensureInitialized()
        .equalsValue(this as UtmStatus, other);
  }

  @override
  int get hashCode {
    return UtmStatusMapper.ensureInitialized().hashValue(this as UtmStatus);
  }
}

extension UtmStatusValueCopy<$R, $Out> on ObjectCopyWith<$R, UtmStatus, $Out> {
  UtmStatusCopyWith<$R, UtmStatus, $Out> get $asUtmStatus =>
      $base.as((v, t, t2) => _UtmStatusCopyWithImpl(v, t, t2));
}

abstract class UtmStatusCopyWith<$R, $In extends UtmStatus, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? utmStatus});
  UtmStatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UtmStatusCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UtmStatus, $Out>
    implements UtmStatusCopyWith<$R, UtmStatus, $Out> {
  _UtmStatusCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UtmStatus> $mapper =
      UtmStatusMapper.ensureInitialized();
  @override
  $R call({String? utmStatus}) =>
      $apply(FieldCopyWithData({if (utmStatus != null) #utmStatus: utmStatus}));
  @override
  UtmStatus $make(CopyWithData data) =>
      UtmStatus(utmStatus: data.get(#utmStatus, or: $value.utmStatus));

  @override
  UtmStatusCopyWith<$R2, UtmStatus, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UtmStatusCopyWithImpl($value, $cast, t);
}
