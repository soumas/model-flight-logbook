// ignore: unused_import
import 'package:intl/intl.dart' as intl;
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
  String get apiResponseReasonFlightsessionNotFound => 'Der angeforderte Flugbucheintrag wurde nicht gefunden';

  @override
  String get apiResponseReasonUnknownPilot => 'Pilot unbekannt';

  @override
  String get apiResponseReasonUnknownTerminal => 'Terminal unbekannt';

  @override
  String get apiResponseReasonInactivePilot => 'Pilot inaktiv';

  @override
  String get apiResponseReasonActiveFlightsessionFound => 'Es wurde ein aktiver Flugbucheintrag gefunden. Beende diesen, bevor du die Aktion erneut ausführst.';
}
