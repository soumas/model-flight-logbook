// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings_state.dart';

class SettingsStateMapper extends ClassMapperBase<SettingsState> {
  SettingsStateMapper._();

  static SettingsStateMapper? _instance;
  static SettingsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsStateMapper._());
      SettingsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsState';

  static bool _$locked(SettingsState v) => v.locked;
  static const Field<SettingsState, bool> _f$locked =
      Field('locked', _$locked, opt: true, def: true);
  static bool _$loading(SettingsState v) => v.loading;
  static const Field<SettingsState, bool> _f$loading =
      Field('loading', _$loading, opt: true, def: false);
  static Settings? _$settings(SettingsState v) => v.settings;
  static const Field<SettingsState, Settings> _f$settings =
      Field('settings', _$settings, opt: true);
  static dynamic _$error(SettingsState v) => v.error;
  static const Field<SettingsState, dynamic> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<SettingsState> fields = const {
    #locked: _f$locked,
    #loading: _f$loading,
    #settings: _f$settings,
    #error: _f$error,
  };

  static SettingsState _instantiate(DecodingData data) {
    return SettingsState(
        locked: data.dec(_f$locked),
        loading: data.dec(_f$loading),
        settings: data.dec(_f$settings),
        error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin SettingsStateMappable {
  SettingsStateCopyWith<SettingsState, SettingsState, SettingsState>
      get copyWith => _SettingsStateCopyWithImpl(
          this as SettingsState, $identity, $identity);
  @override
  String toString() {
    return SettingsStateMapper.ensureInitialized()
        .stringifyValue(this as SettingsState);
  }

  @override
  bool operator ==(Object other) {
    return SettingsStateMapper.ensureInitialized()
        .equalsValue(this as SettingsState, other);
  }

  @override
  int get hashCode {
    return SettingsStateMapper.ensureInitialized()
        .hashValue(this as SettingsState);
  }
}

extension SettingsStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsState, $Out> {
  SettingsStateCopyWith<$R, SettingsState, $Out> get $asSettingsState =>
      $base.as((v, t, t2) => _SettingsStateCopyWithImpl(v, t, t2));
}

abstract class SettingsStateCopyWith<$R, $In extends SettingsState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SettingsCopyWith<$R, Settings, Settings>? get settings;
  $R call({bool? locked, bool? loading, Settings? settings, dynamic error});
  SettingsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SettingsStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsState, $Out>
    implements SettingsStateCopyWith<$R, SettingsState, $Out> {
  _SettingsStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsState> $mapper =
      SettingsStateMapper.ensureInitialized();
  @override
  SettingsCopyWith<$R, Settings, Settings>? get settings =>
      $value.settings?.copyWith.$chain((v) => call(settings: v));
  @override
  $R call(
          {bool? locked,
          bool? loading,
          Object? settings = $none,
          Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (locked != null) #locked: locked,
        if (loading != null) #loading: loading,
        if (settings != $none) #settings: settings,
        if (error != $none) #error: error
      }));
  @override
  SettingsState $make(CopyWithData data) => SettingsState(
      locked: data.get(#locked, or: $value.locked),
      loading: data.get(#loading, or: $value.loading),
      settings: data.get(#settings, or: $value.settings),
      error: data.get(#error, or: $value.error));

  @override
  SettingsStateCopyWith<$R2, SettingsState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SettingsStateCopyWithImpl($value, $cast, t);
}
