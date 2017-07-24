import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import '../../services/logger_service.dart';
import '../../services/game_service.dart';
import '../../services/firebase_service.dart';

import '../login_view/login_view.dart';
import '../game_setup/game_setup.dart';
import '../game_view/game_view.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, LoginView, GameSetup, GameView],
  providers: const [FirebaseService, materialProviders, GameService]
)
class AppComponent {
  final LoggerService _log;
  final FirebaseService fbService;

  bool setUpGame = true;

  AppComponent(LoggerService this._log, this.fbService) {
    _log.info("$runtimeType()");
  }

  void gameReady(bool v) {
    setUpGame = !v;
  }
}
