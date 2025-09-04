// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Sasso Carta Forbici';

  @override
  String get player => 'Giocatore';

  @override
  String get ia => 'IA';

  @override
  String get restart => 'Ricomincia';

  @override
  String get roundDraw => 'Pareggio!';

  @override
  String get iaWin => 'L\'IA vince!';

  @override
  String get userWin => 'Hai vinto!';

  @override
  String get finalLose => 'Hai perso!';

  @override
  String get finalWin => 'Hai vinto!';

  @override
  String get iaChoice => 'SCELTA DELL\'IA';

  @override
  String get userChoice => 'LA TUA SCELTA';
}
