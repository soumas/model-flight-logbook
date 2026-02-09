// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get productname => 'Model Flight Logbook';

  @override
  String versiontag(Object version) {
    return 'Version: $version';
  }

  @override
  String get close => 'Schließen';

  @override
  String get mainMenuSettings => 'Einstellungen';

  @override
  String get validationRequired => 'Pflichtfeld';

  @override
  String get validationNoMatch => 'Stimmt nicht überein';

  @override
  String validationMinLength(Object minLength) {
    return 'Minimale Länge: $minLength';
  }

  @override
  String validationMaxLength(Object maxLength) {
    return 'Maximale Länge: $maxLength';
  }

  @override
  String get validationEmail => 'Ungültige E-Mail Adresse';

  @override
  String get validationUrl => 'Ungültige URL';

  @override
  String get endpointFormFieldTitle => 'Bezeichnung';

  @override
  String get endpointFormFieldServerUrl => 'Server URL';

  @override
  String get endpointFormFieldTerminalId => 'Termina ID';

  @override
  String get endpointFormFieldApiKey => 'API Key';

  @override
  String get settingsEndpoints => 'Verbindungen';

  @override
  String get settingsAddEndpoint => 'Verbindung hinzufügen';

  @override
  String get settingsEditEndpoint => 'Verbindung bearbeiten';

  @override
  String get apiResponseReasonInvalidApiKey => 'Ungültiger Api Key';

  @override
  String get apiResponseReasonFlightsessionNotFound =>
      'Der angeforderte Flugbucheintrag wurde nicht gefunden';

  @override
  String get apiResponseReasonUnknownPilot => 'Pilot unbekannt';

  @override
  String get apiResponseReasonUnknownTerminal => 'Terminal unbekannt';

  @override
  String get apiResponseReasonInactivePilot => 'Pilot inaktiv';

  @override
  String get apiResponseReasonActiveFlightsessionFound =>
      'Es wurde ein aktiver Flugbucheintrag gefunden. Beende diesen, bevor du die Aktion erneut ausführst.';

  @override
  String get exceptionTimeout => 'Zeitüberschreitung';

  @override
  String get exceptionBadResponse => 'Ungültige Antwort';

  @override
  String get exceptionConnectionError => 'Fehler beim Verbindungsaufbau';

  @override
  String get exceptionUnknown => 'Unbekannter Kommunikationsfehler';
}
