import "package:flutter/material.dart";

class L10n {
  static final all = [
    // Français
    const Locale('fr', 'FR'), // France
    const Locale('fr', 'CA'), // Canada

    // Anglais
    const Locale('en', 'US'), // États-Unis
    const Locale('en', 'GB'), // Royaume-Uni
    const Locale('en', 'AU'), // Australie
    const Locale('en', 'CA'), // Canada

    // Espagnol
    const Locale('es', 'ES'), // Espagne
    const Locale('es', 'MX'), // Mexique
    const Locale('es', 'AR'), // Argentine

    // Allemand
    const Locale('de', 'DE'), // Allemagne
    const Locale('de', 'AT'), // Autriche
    const Locale('de', 'CH'), // Suisse

    // Italien
    const Locale('it', 'IT'), // Italie
    const Locale('it', 'CH'), // Suisse

    // Portugais
    const Locale('pt', 'PT'), // Portugal
    const Locale('pt', 'BR'), // Brésil

    // Russe
    const Locale('ru', 'RU'),

    // Chinois
    const Locale('zh', 'CN'), // Simplifié (Chine)
    const Locale('zh', 'TW'), // Traditionnel (Taïwan)
    const Locale('zh', 'HK'), // Traditionnel (Hong Kong)
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
