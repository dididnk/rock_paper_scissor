import 'package:flutter/material.dart';
import 'package:rock_leaf_scissor/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale;

  LocaleProvider([Locale? initialLocale])
      : _locale = initialLocale ?? _getBestMatchingLocale();

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = _getBestMatchingLocale();
    notifyListeners();
  }

  /// Trouve la meilleure locale correspondant à celle du téléphone
  static Locale _getBestMatchingLocale() {
    try {
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;

      // 1. Correspondance exacte (langue + pays)
      final exactMatch = L10n.all.firstWhere(
        (supportedLocale) =>
            supportedLocale.languageCode == deviceLocale.languageCode &&
            supportedLocale.countryCode == deviceLocale.countryCode,
        orElse: () => const Locale('en', 'US'),
      );

      if (exactMatch.languageCode != 'en') {
        return exactMatch;
      }

      // 2. Correspondance uniquement sur la langue
      final languageMatch = L10n.all.firstWhere(
        (supportedLocale) =>
            supportedLocale.languageCode == deviceLocale.languageCode,
        orElse: () => const Locale('en', 'US'),
      );

      return languageMatch;
    } catch (e) {
      return const Locale('en', 'US');
    }
  }

  /// Code langue (ex: "fr")
  String get languageCode => _locale.languageCode;

  /// Code pays (ex: "FR") — peut être null
  String? get countryCode => _locale.countryCode;

  /// Drapeau de la langue (basé sur le code langue)
  String get flag => L10n.getFlag(_locale.languageCode);

  /// Format complet (ex: "fr_FR")
  String get localeCode {
    if (_locale.countryCode != null) {
      return '${_locale.languageCode}_${_locale.countryCode}';
    }
    return _locale.languageCode;
  }
}
