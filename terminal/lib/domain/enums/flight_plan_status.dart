import 'package:dart_mappable/dart_mappable.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';

part 'flight_plan_status.mapper.dart';

@MappableEnum()
enum FlightPlanStatus {
  created,
  featureDisabled,
  startPending,
  flying,
  endPending,
  closed,
  error,
}

extension FlightPlanStatusExt on FlightPlanStatus {
  String toLabel(AppLocalizations localizations) {
    return switch (this) {
      FlightPlanStatus.created => localizations.flightPlanStatusLabelCreated,
      FlightPlanStatus.featureDisabled => localizations.flightPlanStatusLabelFeatureDisabled,
      FlightPlanStatus.startPending => localizations.flightPlanStatusLabelStartPending,
      FlightPlanStatus.flying => localizations.flightPlanStatusLabelFlying,
      FlightPlanStatus.endPending => localizations.flightPlanStatusLabelEndPending,
      FlightPlanStatus.closed => localizations.flightPlanStatusLabelClosed,
      FlightPlanStatus.error => localizations.flightPlanStatusLabelError,
    };
  }
}
