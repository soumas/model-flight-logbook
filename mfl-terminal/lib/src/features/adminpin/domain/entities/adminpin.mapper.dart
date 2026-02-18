// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'adminpin.dart';

class AdminpinMapper extends ClassMapperBase<Adminpin> {
  AdminpinMapper._();

  static AdminpinMapper? _instance;
  static AdminpinMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdminpinMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Adminpin';

  static String _$pin(Adminpin v) => v.pin;
  static const Field<Adminpin, String> _f$pin = Field('pin', _$pin);

  @override
  final MappableFields<Adminpin> fields = const {#pin: _f$pin};

  static Adminpin _instantiate(DecodingData data) {
    return Adminpin(pin: data.dec(_f$pin));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin AdminpinMappable {
  AdminpinCopyWith<Adminpin, Adminpin, Adminpin> get copyWith =>
      _AdminpinCopyWithImpl<Adminpin, Adminpin>(
        this as Adminpin,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AdminpinMapper.ensureInitialized().stringifyValue(this as Adminpin);
  }

  @override
  bool operator ==(Object other) {
    return AdminpinMapper.ensureInitialized().equalsValue(
      this as Adminpin,
      other,
    );
  }

  @override
  int get hashCode {
    return AdminpinMapper.ensureInitialized().hashValue(this as Adminpin);
  }
}

extension AdminpinValueCopy<$R, $Out> on ObjectCopyWith<$R, Adminpin, $Out> {
  AdminpinCopyWith<$R, Adminpin, $Out> get $asAdminpin =>
      $base.as((v, t, t2) => _AdminpinCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AdminpinCopyWith<$R, $In extends Adminpin, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? pin});
  AdminpinCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AdminpinCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Adminpin, $Out>
    implements AdminpinCopyWith<$R, Adminpin, $Out> {
  _AdminpinCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Adminpin> $mapper =
      AdminpinMapper.ensureInitialized();
  @override
  $R call({String? pin}) =>
      $apply(FieldCopyWithData({if (pin != null) #pin: pin}));
  @override
  Adminpin $make(CopyWithData data) =>
      Adminpin(pin: data.get(#pin, or: $value.pin));

  @override
  AdminpinCopyWith<$R2, Adminpin, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AdminpinCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

