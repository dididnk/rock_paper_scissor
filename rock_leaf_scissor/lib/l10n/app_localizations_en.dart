// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Rock Leaf Scissor';

  @override
  String get roundDraw => 'Draw!';

  @override
  String get iaWin => 'AI wins!';

  @override
  String get userWin => 'You win!';

  @override
  String get finalLose => 'You lost!';

  @override
  String get finalWin => 'You win!';

  @override
  String get iaChoice => 'AI CHOICE';

  @override
  String get userChoice => 'YOUR CHOICE';
}
