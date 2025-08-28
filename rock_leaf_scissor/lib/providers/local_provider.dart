import 'package:flutter/material.dart';
import 'package:rock_leaf_scissor/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale;

  LocaleProvider([Locale? initialLocale])
      : _locale = initialLocale ?? WidgetsBinding.instance.platformDispatcher.locale;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = WidgetsBinding.instance.platformDispatcher.locale;
    notifyListeners();
  }
}