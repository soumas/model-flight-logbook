// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dart_mappable/dart_mappable.dart';

import 'package:model_flight_logbook/domain/entities/settings.dart';
import 'package:model_flight_logbook/mappable.dart';

part 'settings_state.mapper.dart';

@mappableStateClass
class SettingsState with SettingsStateMappable {
  final bool locked;
  final bool loading;
  final Settings? settings;
  final dynamic error;
  SettingsState({
    this.locked = true,
    this.loading = false,
    this.settings,
    this.error,
  });
}
