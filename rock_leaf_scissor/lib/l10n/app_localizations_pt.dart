// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Rock Leaf Scissor';

  @override
  String get roundDraw => 'Empate!';

  @override
  String get iaWin => 'A IA venceu!';

  @override
  String get userWin => 'Você venceu!';

  @override
  String get finalLose => 'Você perdeu!';

  @override
  String get finalWin => 'Você venceu!';

  @override
  String get iaChoice => 'ESCOLHA DA IA';

  @override
  String get userChoice => 'SUA ESCOLHA';
}
