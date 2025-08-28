// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Rock Leaf Scissor';

  @override
  String get roundDraw => 'Ничья!';

  @override
  String get iaWin => 'ИИ победил!';

  @override
  String get userWin => 'Вы победили!';

  @override
  String get finalLose => 'Вы проиграли!';

  @override
  String get finalWin => 'Вы победили!';

  @override
  String get iaChoice => 'ВЫБОР ИИ';

  @override
  String get userChoice => 'ВАШ ВЫБОР';
}
