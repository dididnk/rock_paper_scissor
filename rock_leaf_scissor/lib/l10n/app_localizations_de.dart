// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Stein Blatt Schere';

  @override
  String get roundDraw => 'Unentschieden!';

  @override
  String get iaWin => 'KI gewinnt!';

  @override
  String get userWin => 'Du gewinnst!';

  @override
  String get finalLose => 'Du hast verloren!';

  @override
  String get finalWin => 'Du hast gewonnen!';

  @override
  String get iaChoice => 'WAHL DER KI';

  @override
  String get userChoice => 'DEINE WAHL';
}
