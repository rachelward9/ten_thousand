import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import '../../services/logger_service.dart';
import '../../services/game_service.dart';

import '../../components/session_browser/session_browser.dart';

@Component(selector: 'game-setup',
    templateUrl: 'game_setup.html',
    directives: const [CORE_DIRECTIVES, materialDirectives, SessionBrowser]
)
class GameSetup {
  final LoggerService _log;
  final GameService gameService;
  String sessionName;

  final StreamController<bool> _gameReady = new StreamController<bool>.broadcast();
  @Output() Stream<bool> get gameReady => _gameReady.stream;

  String name = "";

  GameSetup(LoggerService this._log, GameService this.gameService) {
    _log.info("$runtimeType()");
  }

//  TODO: Fix this throughout the app. It's adding players under "sessions", since I didn't update that code yet.
  void addPlayer() {
    gameService.addPlayer(name);
    name = "";
  }

  void startGame() {
    if (gameService.players.isNotEmpty && (sessionName != null && sessionName.isNotEmpty)) {
      gameService.createGame(sessionName);
      _gameReady.add(true);
    }
  }
}