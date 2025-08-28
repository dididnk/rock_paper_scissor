import "package:flutter/material.dart";

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('fr'),
    const Locale('es'),
    const Locale('de'),
    const Locale('it'),
    const Locale('pt'), // Portugais
    const Locale('ru'), // Russe
    const Locale('zh'), // Chinois (Mandarin)
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'fr':
        return '🇫🇷';
      case 'es':
        return '🇪🇸';
      case 'de':
        return '🇩🇪';
      case 'it':
        return '🇮🇹';
      case 'pt':
        return '🇵🇹🇧🇷';
      case 'ru':
        return '🇷🇺';
      case 'zh':
        return '🇨🇳';
      default:
        return '🏳️';
    }
  }
}
