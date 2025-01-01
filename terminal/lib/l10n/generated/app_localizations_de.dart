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
  String get apiResponseReasonUnknownPilot => 'Pilot:in unbekannt';

  @override
  String get apiResponseReasonUnknownTerminal => 'Terminal unbekannt';

  @override
  String get apiResponseReasonInactivePilot => 'Pilot:in inaktiv';

  @override
  String get apiResponseReasonActiveFlightsessionFound => 'Es wurde ein aktiver Flugtag gefunden. Beende diesen, bevor du die Aktion erneut ausführst.';
}
