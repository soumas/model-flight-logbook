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
  String get apiResponseReasonInactivePilot => 'Die Interaktion mit dem Server wurde verweigert, da das Pilotenkonto inaktiv ist.';

  @override
  String get apiResponseReasonActiveFlightsessionFound => 'Es wurde ein aktiver Flugtag gefunden. Beende diesen, bevor du die Aktion erneut ausführst.';

  @override
  String get apiResponseReasonUtmActionRunning => 'Es findet eine Interaktion mit dem UTM System der Austro Control statt. Bitte führe die gewünschte Aktion in wenigen Minuten erneut aus.';

  @override
  String get flightPlanStatusLabelCreated => 'Neu erstellt';

  @override
  String get flightPlanStatusLabelFeatureDisabled => 'UTM Feature inaktiv';

  @override
  String get flightPlanStatusLabelStartPending => 'Warte auf Freigabe';

  @override
  String get flightPlanStatusLabelFlying => 'Freigabe erteilt (flying)';

  @override
  String get flightPlanStatusLabelEndPending => 'Warte auf Beendigung';

  @override
  String get flightPlanStatusLabelClosed => 'Abgeschlossen (closed)';

  @override
  String get flightPlanStatusLabelError => 'Fehler';
}
