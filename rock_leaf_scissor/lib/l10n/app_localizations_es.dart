// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Rock Leaf Scissor';

  @override
  String get player => 'Jugador';

  @override
  String get ia => 'IA';

  @override
  String get restart => 'Reiniciar';

  @override
  String get roundDraw => '¡Empate!';

  @override
  String get iaWin => '¡La IA gana!';

  @override
  String get userWin => '¡Tú ganas!';

  @override
  String get finalLose => '¡Has perdido!';

  @override
  String get finalWin => '¡Has ganado!';

  @override
  String get iaChoice => 'ELECCIÓN DE LA IA';

  @override
  String get userChoice => 'TU ELECCIÓN';
}
