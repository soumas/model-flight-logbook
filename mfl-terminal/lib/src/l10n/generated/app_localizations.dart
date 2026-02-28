import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('de')];

  /// No description provided for @productname.
  ///
  /// In de, this message translates to:
  /// **'Model Flight Logbook'**
  String get productname;

  /// No description provided for @versiontag.
  ///
  /// In de, this message translates to:
  /// **'Version: {version}'**
  String versiontag(Object version);

  /// No description provided for @close.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get close;

  /// No description provided for @error.
  ///
  /// In de, this message translates to:
  /// **'Fehler'**
  String get error;

  /// No description provided for @saveAnyway.
  ///
  /// In de, this message translates to:
  /// **'Trotzdem speichern'**
  String get saveAnyway;

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// No description provided for @add.
  ///
  /// In de, this message translates to:
  /// **'Hinzufügen'**
  String get add;

  /// No description provided for @save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// No description provided for @takeOver.
  ///
  /// In de, this message translates to:
  /// **'Übernehmen'**
  String get takeOver;

  /// No description provided for @delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// No description provided for @saveSuccess.
  ///
  /// In de, this message translates to:
  /// **'Erfolgreich gespeichert'**
  String get saveSuccess;

  /// No description provided for @functionNotSupported.
  ///
  /// In de, this message translates to:
  /// **'Diese Funktion wird nicht unterstützt'**
  String get functionNotSupported;

  /// No description provided for @mainMenuSettings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get mainMenuSettings;

  /// No description provided for @validationRequired.
  ///
  /// In de, this message translates to:
  /// **'Pflichtfeld'**
  String get validationRequired;

  /// No description provided for @validationNoMatch.
  ///
  /// In de, this message translates to:
  /// **'Stimmt nicht überein'**
  String get validationNoMatch;

  /// No description provided for @validationMinLength.
  ///
  /// In de, this message translates to:
  /// **'Minimale Länge: {minLength}'**
  String validationMinLength(Object minLength);

  /// No description provided for @validationMaxLength.
  ///
  /// In de, this message translates to:
  /// **'Maximale Länge: {maxLength}'**
  String validationMaxLength(Object maxLength);

  /// No description provided for @validationEmail.
  ///
  /// In de, this message translates to:
  /// **'Ungültige E-Mail Adresse'**
  String get validationEmail;

  /// No description provided for @validationUrl.
  ///
  /// In de, this message translates to:
  /// **'Ungültige URL'**
  String get validationUrl;

  /// No description provided for @endpointFormFieldTitle.
  ///
  /// In de, this message translates to:
  /// **'Bezeichnung'**
  String get endpointFormFieldTitle;

  /// No description provided for @endpointFormFieldServerUrl.
  ///
  /// In de, this message translates to:
  /// **'Server URL'**
  String get endpointFormFieldServerUrl;

  /// No description provided for @endpointFormFieldTerminalId.
  ///
  /// In de, this message translates to:
  /// **'Termina ID'**
  String get endpointFormFieldTerminalId;

  /// No description provided for @endpointFormFieldApiKey.
  ///
  /// In de, this message translates to:
  /// **'API Key'**
  String get endpointFormFieldApiKey;

  /// No description provided for @settingsEndpoints.
  ///
  /// In de, this message translates to:
  /// **'Verbindungen'**
  String get settingsEndpoints;

  /// No description provided for @settingsAddEndpoint.
  ///
  /// In de, this message translates to:
  /// **'Verbindung hinzufügen'**
  String get settingsAddEndpoint;

  /// No description provided for @settingsEditEndpoint.
  ///
  /// In de, this message translates to:
  /// **'Verbindung bearbeiten'**
  String get settingsEditEndpoint;

  /// No description provided for @settingsDeleteEndpointConfirmation.
  ///
  /// In de, this message translates to:
  /// **'Möchten Sie die Verbindung \'{name}\' wirklich löschen?'**
  String settingsDeleteEndpointConfirmation(Object name);

  /// No description provided for @settingsOthers.
  ///
  /// In de, this message translates to:
  /// **'Sonstiges'**
  String get settingsOthers;

  /// No description provided for @settingsAdminpin.
  ///
  /// In de, this message translates to:
  /// **'Admin PIN'**
  String get settingsAdminpin;

  /// No description provided for @settingsAdminpinForgotten.
  ///
  /// In de, this message translates to:
  /// **'Wenn Sie den Admin PIN vergessen haben, können Sie den Screen mit einem Terminal API-Key freischalten.'**
  String get settingsAdminpinForgotten;

  /// No description provided for @settingsAdminpinText.
  ///
  /// In de, this message translates to:
  /// **'Setzen Sie einen Admin PIN um diese Administrationsmaske vor unerwünschten Zugriffen zu schützen. Um den Admin PIN zurückzusetzen setzen Sie einen leeren Admin PIN.'**
  String get settingsAdminpinText;

  /// No description provided for @settingsAdminpinInvalid.
  ///
  /// In de, this message translates to:
  /// **'Ungültiger Admin PIN'**
  String get settingsAdminpinInvalid;

  /// No description provided for @settingsAdminpinUnlockText.
  ///
  /// In de, this message translates to:
  /// **'Bitte geben Sie den Admin PIN ein, um auf die Einstellungen zu gelangen.'**
  String get settingsAdminpinUnlockText;

  /// No description provided for @settingsAdminpinSaved.
  ///
  /// In de, this message translates to:
  /// **'Admin PIN gespeichert'**
  String get settingsAdminpinSaved;

  /// No description provided for @settingsAdminpinResetted.
  ///
  /// In de, this message translates to:
  /// **'Admin PIN zurückgesetzt'**
  String get settingsAdminpinResetted;

  /// No description provided for @apiResponseReasonInvalidApiKey.
  ///
  /// In de, this message translates to:
  /// **'Ungültiger Api Key'**
  String get apiResponseReasonInvalidApiKey;

  /// No description provided for @apiResponseReasonFlightsessionNotFound.
  ///
  /// In de, this message translates to:
  /// **'Der angeforderte Flugbucheintrag wurde nicht gefunden'**
  String get apiResponseReasonFlightsessionNotFound;

  /// No description provided for @apiResponseReasonUnknownPilot.
  ///
  /// In de, this message translates to:
  /// **'Pilot unbekannt'**
  String get apiResponseReasonUnknownPilot;

  /// No description provided for @apiResponseReasonUnknownTerminal.
  ///
  /// In de, this message translates to:
  /// **'Terminal unbekannt'**
  String get apiResponseReasonUnknownTerminal;

  /// No description provided for @apiResponseReasonInactivePilot.
  ///
  /// In de, this message translates to:
  /// **'Pilot inaktiv'**
  String get apiResponseReasonInactivePilot;

  /// No description provided for @apiResponseReasonActiveFlightsessionFound.
  ///
  /// In de, this message translates to:
  /// **'Es wurde ein aktiver Flugbucheintrag gefunden. Beende diesen, bevor du die Aktion erneut ausführst.'**
  String get apiResponseReasonActiveFlightsessionFound;

  /// No description provided for @exceptionTimeout.
  ///
  /// In de, this message translates to:
  /// **'Zeitüberschreitung'**
  String get exceptionTimeout;

  /// No description provided for @exceptionBadResponse.
  ///
  /// In de, this message translates to:
  /// **'Ungültige Antwort'**
  String get exceptionBadResponse;

  /// No description provided for @exceptionConnectionError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Verbindungsaufbau'**
  String get exceptionConnectionError;

  /// No description provided for @exceptionUnknown.
  ///
  /// In de, this message translates to:
  /// **'Unbekannter Fehler'**
  String get exceptionUnknown;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
