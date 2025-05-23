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
    }
    return _instance!;
  }

  @override
  final String id = 'TerminalStatus';

  static DateTime? _$statusReceiveTime(TerminalStatus v) => v.statusReceiveTime;
  static const Field<TerminalStatus, DateTime> _f$statusReceiveTime =
      Field('statusReceiveTime', _$statusReceiveTime, opt: true);
  static DateTime? _$operatinghourStart(TerminalStatus v) =>
      v.operatinghourStart;
  static const Field<TerminalStatus, DateTime> _f$operatinghourStart =
      Field('operatinghourStart', _$operatinghourStart, opt: true);
  static DateTime? _$operatinghourEnd(TerminalStatus v) => v.operatinghourEnd;
  static const Field<TerminalStatus, DateTime> _f$operatinghourEnd =
      Field('operatinghourEnd', _$operatinghourEnd, opt: true);
  static List<String>? _$infoMessages(TerminalStatus v) => v.infoMessages;
  static const Field<TerminalStatus, List<String>> _f$infoMessages =
      Field('infoMessages', _$infoMessages, opt: true);
  static List<String>? _$warnMessages(TerminalStatus v) => v.warnMessages;
  static const Field<TerminalStatus, List<String>> _f$warnMessages =
      Field('warnMessages', _$warnMessages, opt: true);
  static List<String>? _$errorMessages(TerminalStatus v) => v.errorMessages;
  static const Field<TerminalStatus, List<String>> _f$errorMessages =
      Field('errorMessages', _$errorMessages, opt: true);

  @override
  final MappableFields<TerminalStatus> fields = const {
    #statusReceiveTime: _f$statusReceiveTime,
    #operatinghourStart: _f$operatinghourStart,
    #operatinghourEnd: _f$operatinghourEnd,
    #infoMessages: _f$infoMessages,
    #warnMessages: _f$warnMessages,
    #errorMessages: _f$errorMessages,
  };

  static TerminalStatus _instantiate(DecodingData data) {
    return TerminalStatus(
        statusReceiveTime: data.dec(_f$statusReceiveTime),
        operatinghourStart: data.dec(_f$operatinghourStart),
        operatinghourEnd: data.dec(_f$operatinghourEnd),
        infoMessages: data.dec(_f$infoMessages),
        warnMessages: data.dec(_f$warnMessages),
        errorMessages: data.dec(_f$errorMessages));
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get infoMessages;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get warnMessages;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get errorMessages;
  $R call(
      {DateTime? statusReceiveTime,
      DateTime? operatinghourStart,
      DateTime? operatinghourEnd,
      List<String>? infoMessages,
      List<String>? warnMessages,
      List<String>? errorMessages});
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
          {Object? statusReceiveTime = $none,
          Object? operatinghourStart = $none,
          Object? operatinghourEnd = $none,
          Object? infoMessages = $none,
          Object? warnMessages = $none,
          Object? errorMessages = $none}) =>
      $apply(FieldCopyWithData({
        if (statusReceiveTime != $none) #statusReceiveTime: statusReceiveTime,
        if (operatinghourStart != $none)
          #operatinghourStart: operatinghourStart,
        if (operatinghourEnd != $none) #operatinghourEnd: operatinghourEnd,
        if (infoMessages != $none) #infoMessages: infoMessages,
        if (warnMessages != $none) #warnMessages: warnMessages,
        if (errorMessages != $none) #errorMessages: errorMessages
      }));
  @override
  TerminalStatus $make(CopyWithData data) => TerminalStatus(
      statusReceiveTime:
          data.get(#statusReceiveTime, or: $value.statusReceiveTime),
      operatinghourStart:
          data.get(#operatinghourStart, or: $value.operatinghourStart),
      operatinghourEnd:
          data.get(#operatinghourEnd, or: $value.operatinghourEnd),
      infoMessages: data.get(#infoMessages, or: $value.infoMessages),
      warnMessages: data.get(#warnMessages, or: $value.warnMessages),
      errorMessages: data.get(#errorMessages, or: $value.errorMessages));

  @override
  TerminalStatusCopyWith<$R2, TerminalStatus, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TerminalStatusCopyWithImpl($value, $cast, t);
}
