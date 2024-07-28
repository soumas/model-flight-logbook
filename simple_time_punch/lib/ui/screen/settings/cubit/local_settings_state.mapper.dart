// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_settings_state.dart';

class LocalSettingsStateMapper extends ClassMapperBase<LocalSettingsState> {
  LocalSettingsStateMapper._();

  static LocalSettingsStateMapper? _instance;
  static LocalSettingsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalSettingsStateMapper._());
      LocalSettingsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalSettingsState';

  static bool _$loading(LocalSettingsState v) => v.loading;
  static const Field<LocalSettingsState, bool> _f$loading =
      Field('loading', _$loading, opt: true, def: false);
  static LocalSettings? _$settings(LocalSettingsState v) => v.settings;
  static const Field<LocalSettingsState, LocalSettings> _f$settings =
      Field('settings', _$settings, opt: true);
  static dynamic _$error(LocalSettingsState v) => v.error;
  static const Field<LocalSettingsState, dynamic> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<LocalSettingsState> fields = const {
    #loading: _f$loading,
    #settings: _f$settings,
    #error: _f$error,
  };

  static LocalSettingsState _instantiate(DecodingData data) {
    return LocalSettingsState(
        loading: data.dec(_f$loading),
        settings: data.dec(_f$settings),
        error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin LocalSettingsStateMappable {
  LocalSettingsStateCopyWith<LocalSettingsState, LocalSettingsState,
          LocalSettingsState>
      get copyWith => _LocalSettingsStateCopyWithImpl(
          this as LocalSettingsState, $identity, $identity);
  @override
  String toString() {
    return LocalSettingsStateMapper.ensureInitialized()
        .stringifyValue(this as LocalSettingsState);
  }

  @override
  bool operator ==(Object other) {
    return LocalSettingsStateMapper.ensureInitialized()
        .equalsValue(this as LocalSettingsState, other);
  }

  @override
  int get hashCode {
    return LocalSettingsStateMapper.ensureInitialized()
        .hashValue(this as LocalSettingsState);
  }
}

extension LocalSettingsStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalSettingsState, $Out> {
  LocalSettingsStateCopyWith<$R, LocalSettingsState, $Out>
      get $asLocalSettingsState =>
          $base.as((v, t, t2) => _LocalSettingsStateCopyWithImpl(v, t, t2));
}

abstract class LocalSettingsStateCopyWith<$R, $In extends LocalSettingsState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  LocalSettingsCopyWith<$R, LocalSettings, LocalSettings>? get settings;
  $R call({bool? loading, LocalSettings? settings, dynamic error});
  LocalSettingsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _LocalSettingsStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalSettingsState, $Out>
    implements LocalSettingsStateCopyWith<$R, LocalSettingsState, $Out> {
  _LocalSettingsStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalSettingsState> $mapper =
      LocalSettingsStateMapper.ensureInitialized();
  @override
  LocalSettingsCopyWith<$R, LocalSettings, LocalSettings>? get settings =>
      $value.settings?.copyWith.$chain((v) => call(settings: v));
  @override
  $R call({bool? loading, Object? settings = $none, Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (loading != null) #loading: loading,
        if (settings != $none) #settings: settings,
        if (error != $none) #error: error
      }));
  @override
  LocalSettingsState $make(CopyWithData data) => LocalSettingsState(
      loading: data.get(#loading, or: $value.loading),
      settings: data.get(#settings, or: $value.settings),
      error: data.get(#error, or: $value.error));

  @override
  LocalSettingsStateCopyWith<$R2, LocalSettingsState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LocalSettingsStateCopyWithImpl($value, $cast, t);
}
