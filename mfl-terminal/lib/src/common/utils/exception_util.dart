import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/l10n/generated/app_localizations.dart';

class ExceptionUtil {
  static String getUiMessage(dynamic e, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    if (e is DioException) {
      try {
        if (e.response?.data['detail'] != null) {
          final reason = ApiResponseReasonExt.fromString(e.response?.data['detail']);
          if (reason != null) {
            return ApiResponseReasonExt.getDescription(reason, localizations);
          }
        }
      } catch (_) {}

      switch (e.type) {
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
          return localizations.exceptionTimeout;
        case DioExceptionType.badResponse:
          return localizations.exceptionBadResponse;
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
          return localizations.exceptionConnectionError;
        case DioExceptionType.unknown:
        default:
          return e.message ?? localizations.exceptionUnknown;
      }
    }
    return localizations.exceptionUnknown;
  }
}

enum ApiResponseReason { invalidApiKey, flightsessionNotFound, unknownPilot, unknownTerminal, inactivePilot, activeFlightsessionFound }

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
