// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'end_flight_session_data.dart';

class EndFlightSessionDataMapper extends ClassMapperBase<EndFlightSessionData> {
  EndFlightSessionDataMapper._();

  static EndFlightSessionDataMapper? _instance;
  static EndFlightSessionDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EndFlightSessionDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EndFlightSessionData';

  static int? _$takeoffcount(EndFlightSessionData v) => v.takeoffcount;
  static const Field<EndFlightSessionData, int> _f$takeoffcount = Field('takeoffcount', _$takeoffcount, opt: true);
  static String? _$comment(EndFlightSessionData v) => v.comment;
  static const Field<EndFlightSessionData, String> _f$comment = Field('comment', _$comment, opt: true);

  @override
  final MappableFields<EndFlightSessionData> fields = const {
    #takeoffcount: _f$takeoffcount,
    #comment: _f$comment,
  };

  static EndFlightSessionData _instantiate(DecodingData data) {
    return EndFlightSessionData(takeoffcount: data.dec(_f$takeoffcount), comment: data.dec(_f$comment));
  }

  @override
  final Function instantiate = _instantiate;

  static EndFlightSessionData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EndFlightSessionData>(map);
  }

  static EndFlightSessionData fromJson(String json) {
    return ensureInitialized().decodeJson<EndFlightSessionData>(json);
  }
}

mixin EndFlightSessionDataMappable {
  String toJson() {
    return EndFlightSessionDataMapper.ensureInitialized().encodeJson<EndFlightSessionData>(this as EndFlightSessionData);
  }

  Map<String, dynamic> toMap() {
    return EndFlightSessionDataMapper.ensureInitialized().encodeMap<EndFlightSessionData>(this as EndFlightSessionData);
  }

  EndFlightSessionDataCopyWith<EndFlightSessionData, EndFlightSessionData, EndFlightSessionData> get copyWith => _EndFlightSessionDataCopyWithImpl(this as EndFlightSessionData, $identity, $identity);
  @override
  String toString() {
    return EndFlightSessionDataMapper.ensureInitialized().stringifyValue(this as EndFlightSessionData);
  }

  @override
  bool operator ==(Object other) {
    return EndFlightSessionDataMapper.ensureInitialized().equalsValue(this as EndFlightSessionData, other);
  }

  @override
  int get hashCode {
    return EndFlightSessionDataMapper.ensureInitialized().hashValue(this as EndFlightSessionData);
  }
}

extension EndFlightSessionDataValueCopy<$R, $Out> on ObjectCopyWith<$R, EndFlightSessionData, $Out> {
  EndFlightSessionDataCopyWith<$R, EndFlightSessionData, $Out> get $asEndFlightSessionData => $base.as((v, t, t2) => _EndFlightSessionDataCopyWithImpl(v, t, t2));
}

abstract class EndFlightSessionDataCopyWith<$R, $In extends EndFlightSessionData, $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? takeoffcount, String? comment});
  EndFlightSessionDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EndFlightSessionDataCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, EndFlightSessionData, $Out> implements EndFlightSessionDataCopyWith<$R, EndFlightSessionData, $Out> {
  _EndFlightSessionDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EndFlightSessionData> $mapper = EndFlightSessionDataMapper.ensureInitialized();
  @override
  $R call({Object? takeoffcount = $none, Object? comment = $none}) => $apply(FieldCopyWithData({if (takeoffcount != $none) #takeoffcount: takeoffcount, if (comment != $none) #comment: comment}));
  @override
  EndFlightSessionData $make(CopyWithData data) => EndFlightSessionData(takeoffcount: data.get(#takeoffcount, or: $value.takeoffcount), comment: data.get(#comment, or: $value.comment));

  @override
  EndFlightSessionDataCopyWith<$R2, EndFlightSessionData, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) => _EndFlightSessionDataCopyWithImpl($value, $cast, t);
}
