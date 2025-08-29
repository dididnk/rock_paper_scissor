import "package:flutter/material.dart";

class L10n {
  static final all = [
    // Français
    const Locale('fr', ''), // France

    // Anglais
    const Locale('en', 'US'), // États-Unis

    // Espagnol
    const Locale('es', ''), // Espagne

    // Allemand
    const Locale('de', ''), // Allemagne

    // Italien
    const Locale('it', ''), // Italie

    // Portugais
    const Locale('pt', ''), // Portugal

    // Russe
    const Locale('ru', ''),

    // Chinois
    const Locale('zh', ''), // Simplifié (Chine)
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'fr':
        return '🇫🇷';
      case 'en':
        return '🇺🇸';
      case 'es':
        return '🇪🇸';
      case 'de':
        return '🇩🇪';
      case 'it':
        return '🇮🇹';
      case 'pt':
        return '🇵🇹';
      case 'ru':
        return '🇷🇺';
      case 'zh':
        return '🇨🇳';
      default:
        return '🏳️';
    }
  }
}
