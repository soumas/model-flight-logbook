// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'utm_sync_status.dart';

class UtmSyncStatusMapper extends EnumMapper<UtmSyncStatus> {
  UtmSyncStatusMapper._();

  static UtmSyncStatusMapper? _instance;
  static UtmSyncStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UtmSyncStatusMapper._());
    }
    return _instance!;
  }

  static UtmSyncStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  UtmSyncStatus decode(dynamic value) {
    switch (value) {
      case 'unknown':
        return UtmSyncStatus.unknown;
      case 'noActiveFlight':
        return UtmSyncStatus.noActiveFlight;
      case 'flying':
        return UtmSyncStatus.flying;
      case 'error':
        return UtmSyncStatus.error;
      case 'updateFailed':
        return UtmSyncStatus.updateFailed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(UtmSyncStatus self) {
    switch (self) {
      case UtmSyncStatus.unknown:
        return 'unknown';
      case UtmSyncStatus.noActiveFlight:
        return 'noActiveFlight';
      case UtmSyncStatus.flying:
        return 'flying';
      case UtmSyncStatus.error:
        return 'error';
      case UtmSyncStatus.updateFailed:
        return 'updateFailed';
    }
  }
}

extension UtmSyncStatusMapperExtension on UtmSyncStatus {
  String toValue() {
    UtmSyncStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<UtmSyncStatus>(this) as String;
  }
}
