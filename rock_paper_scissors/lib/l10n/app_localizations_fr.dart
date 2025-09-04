// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Pierre Papier Ciseaux';

  @override
  String get player => 'Joueur';

  @override
  String get ia => 'IA';

  @override
  String get restart => 'Recommencer';

  @override
  String get roundDraw => 'Égalité !';

  @override
  String get iaWin => 'L\'IA gagne !';

  @override
  String get userWin => 'Vous gagnez !';

  @override
  String get finalLose => 'Vous avez perdu !';

  @override
  String get finalWin => 'Vous avez gagné !';

  @override
  String get iaChoice => 'CHOIX DE L\'IA';

  @override
  String get userChoice => 'VOTRE CHOIX';
}
