import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/services/logger_service.dart';
import 'src/services/game_service.dart';
import 'src/services/firebase_service.dart';

import 'src/views/login_view/login_view.dart';
import 'src/views/app_nav/app_nav.dart';
import 'src/views/game_setup/game_setup.dart';
import 'src/views/game_view/game_view.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [CORE_DIRECTIVES, materialDirectives, LoginView, GameSetup, GameView, AppNav],
  providers: const [materialProviders, GameService]
)
class AppComponent {
  final LoggerService _log;
  final FirebaseService fbService;

  bool setUpGame = true;

  AppComponent(this._log, this.fbService) {
    _log.info("$runtimeType()");
  }

  void gameReady(bool v) {
    setUpGame = !v;
  }
}
