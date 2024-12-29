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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de')
  ];

  /// No description provided for @settings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settings;

  /// No description provided for @addServerConnection.
  ///
  /// In de, this message translates to:
  /// **'Server hinzufügen'**
  String get addServerConnection;

  /// No description provided for @apiResponseReasonInvalidApiKey.
  ///
  /// In de, this message translates to:
  /// **'Ungültiger Api Key'**
  String get apiResponseReasonInvalidApiKey;

  /// No description provided for @apiResponseReasonFlightsessionNotFound.
  ///
  /// In de, this message translates to:
  /// **'Die angeforderte Sitzung wurde nicht gefunden'**
  String get apiResponseReasonFlightsessionNotFound;

  /// No description provided for @apiResponseReasonUnknownPilot.
  ///
  /// In de, this message translates to:
  /// **'Pilot:in unbekannt'**
  String get apiResponseReasonUnknownPilot;

  /// No description provided for @apiResponseReasonUnknownTerminal.
  ///
  /// In de, this message translates to:
  /// **'Terminal unbekannt'**
  String get apiResponseReasonUnknownTerminal;

  /// No description provided for @apiResponseReasonInactivePilot.
  ///
  /// In de, this message translates to:
  /// **'Pilot:in inaktiv'**
  String get apiResponseReasonInactivePilot;

  /// No description provided for @apiResponseReasonActiveFlightsessionFound.
  ///
  /// In de, this message translates to:
  /// **'Es wurde eine aktive Sitzung gefunden. Beende diesen, bevor du die Aktion erneut ausführst.'**
  String get apiResponseReasonActiveFlightsessionFound;

  /// No description provided for @apiResponseReasonUtmActionRunning.
  ///
  /// In de, this message translates to:
  /// **'UTM Interaktion in Ausführung.'**
  String get apiResponseReasonUtmActionRunning;

  /// No description provided for @flightPlanStatusLabelCreated.
  ///
  /// In de, this message translates to:
  /// **'Neu erstellt'**
  String get flightPlanStatusLabelCreated;

  /// No description provided for @flightPlanStatusLabelFeatureDisabled.
  ///
  /// In de, this message translates to:
  /// **'UTM Feature inaktiv'**
  String get flightPlanStatusLabelFeatureDisabled;

  /// No description provided for @flightPlanStatusLabelStartPending.
  ///
  /// In de, this message translates to:
  /// **'Warte auf Freigabe'**
  String get flightPlanStatusLabelStartPending;

  /// No description provided for @flightPlanStatusLabelFlying.
  ///
  /// In de, this message translates to:
  /// **'Freigabe erteilt'**
  String get flightPlanStatusLabelFlying;

  /// No description provided for @flightPlanStatusLabelEndPending.
  ///
  /// In de, this message translates to:
  /// **'Warte auf Beendigung'**
  String get flightPlanStatusLabelEndPending;

  /// No description provided for @flightPlanStatusLabelClosed.
  ///
  /// In de, this message translates to:
  /// **'Abgeschlossen'**
  String get flightPlanStatusLabelClosed;

  /// No description provided for @flightPlanStatusLabelError.
  ///
  /// In de, this message translates to:
  /// **'Fehler'**
  String get flightPlanStatusLabelError;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
