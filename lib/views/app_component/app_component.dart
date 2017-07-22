import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import '../../services/logger_service.dart';
import '../../services/game_service.dart';
import '../game_setup/game_setup.dart';
import '../game_view/game_view.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, GameSetup, GameView],
  providers: const [materialProviders, GameService]
)
class AppComponent {
  final LoggerService _log;

  bool setUpGame = true;

  AppComponent(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

  void gameReady(bool v) {
    setUpGame = !v;
  }
}
