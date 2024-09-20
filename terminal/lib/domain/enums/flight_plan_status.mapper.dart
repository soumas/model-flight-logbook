// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'flight_plan_status.dart';

class FlightPlanStatusMapper extends EnumMapper<FlightPlanStatus> {
  FlightPlanStatusMapper._();

  static FlightPlanStatusMapper? _instance;
  static FlightPlanStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlightPlanStatusMapper._());
    }
    return _instance!;
  }

  static FlightPlanStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  FlightPlanStatus decode(dynamic value) {
    switch (value) {
      case 'created':
        return FlightPlanStatus.created;
      case 'featureDisabled':
        return FlightPlanStatus.featureDisabled;
      case 'startPending':
        return FlightPlanStatus.startPending;
      case 'flying':
        return FlightPlanStatus.flying;
      case 'endPending':
        return FlightPlanStatus.endPending;
      case 'closed':
        return FlightPlanStatus.closed;
      case 'error':
        return FlightPlanStatus.error;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(FlightPlanStatus self) {
    switch (self) {
      case FlightPlanStatus.created:
        return 'created';
      case FlightPlanStatus.featureDisabled:
        return 'featureDisabled';
      case FlightPlanStatus.startPending:
        return 'startPending';
      case FlightPlanStatus.flying:
        return 'flying';
      case FlightPlanStatus.endPending:
        return 'endPending';
      case FlightPlanStatus.closed:
        return 'closed';
      case FlightPlanStatus.error:
        return 'error';
    }
  }
}

extension FlightPlanStatusMapperExtension on FlightPlanStatus {
  String toValue() {
    FlightPlanStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<FlightPlanStatus>(this) as String;
  }
}
