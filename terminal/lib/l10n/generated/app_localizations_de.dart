import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get settings => 'Einstellungen';

  @override
  String get addServerConnection => 'Server hinzufügen';

  @override
  String get apiResponseReasonInvalidApiKey => 'Ungültiger Api Key';

  @override
  String get apiResponseReasonFlightsessionNotFound => 'Der angeforderte Flugtag wurde nicht gefunden';

  @override
  String get apiResponseReasonUnknownPilot => 'Unbekannter Pilot';

  @override
  String get apiResponseReasonUnknownTerminal => 'Unbekanntes Terminal';

  @override
  String get apiResponseReasonInactivePilot => 'Inaktiver Pilot';

  @override
  String get apiResponseReasonActiveFlightsessionFound => 'Es wurde ein aktiver Flugtag gefunden. Beenden Sie diesen, bevor Sie die Aktion erneut ausführen.';

  @override
  String get apiResponseReasonUtmActionRunning => 'Es findet eine Interaktion mit dem UTM System der Austro Control statt. Bitte führen Sie die Aktion in wenigen Minuten erneut aus.';
}
