import 'package:dio/dio.dart';
import 'package:model_flight_logbook/domain/enums/api_response_reason.dart';
import 'package:model_flight_logbook/l10n/generated/app_localizations.dart';

class DioExceptionUtil {
  static String? getUiMessage(dynamic e, AppLocalizations localizations) {
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
          return 'Zeitüberschreitung';
        case DioExceptionType.badResponse:
          return 'Ungültige Antwort';
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
          return 'Fehler beim Verbindungsaufbau';
        case DioExceptionType.unknown:
        default:
          return e.message ?? 'Unbekannter Kommunikationsfehler';
      }
    }
    return null;
  }
}
