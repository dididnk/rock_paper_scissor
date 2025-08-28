// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Rock Leaf Scissor';

  @override
  String get roundDraw => '平局！';

  @override
  String get iaWin => 'AI获胜！';

  @override
  String get userWin => '你赢了！';

  @override
  String get finalLose => '你输了！';

  @override
  String get finalWin => '你赢了！';

  @override
  String get iaChoice => 'AI选择';

  @override
  String get userChoice => '你的选择';
}
