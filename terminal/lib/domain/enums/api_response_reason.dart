import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';

enum ApiResponseReason {
  invalidApiKey,
  flightsessionNotFound,
  unknownPilot,
  unknownTerminal,
  inactivePilot,
  activeFlightsessionFound,
}

extension ApiResponseReasonExt on ApiResponseReason {
  static ApiResponseReason? fromString(String key) {
    switch (key) {
      case 'INVALID_API_KEY':
        return ApiResponseReason.invalidApiKey;
      case 'FLIGHTSESSION_NOT_FOUND':
        return ApiResponseReason.flightsessionNotFound;
      case 'UNKNOWN_PILOT':
        return ApiResponseReason.unknownPilot;
      case 'UNKNOWN_TERMINAL':
        return ApiResponseReason.unknownTerminal;
      case 'INACTIVE_PILOT':
        return ApiResponseReason.inactivePilot;
      case 'ACTIVE_FLIGHTSESSION_FOUND':
        return ApiResponseReason.activeFlightsessionFound;
    }
    return null;
  }

  static String getDescription(ApiResponseReason reason, AppLocalizations localizations) {
    switch (reason) {
      case ApiResponseReason.invalidApiKey:
        return localizations.apiResponseReasonInvalidApiKey;
      case ApiResponseReason.flightsessionNotFound:
        return localizations.apiResponseReasonFlightsessionNotFound;
      case ApiResponseReason.unknownPilot:
        return localizations.apiResponseReasonUnknownPilot;
      case ApiResponseReason.unknownTerminal:
        return localizations.apiResponseReasonUnknownTerminal;
      case ApiResponseReason.inactivePilot:
        return localizations.apiResponseReasonInactivePilot;
      case ApiResponseReason.activeFlightsessionFound:
        return localizations.apiResponseReasonActiveFlightsessionFound;
    }
  }
}
