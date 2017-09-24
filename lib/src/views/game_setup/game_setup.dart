import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../services/logger_service.dart';
import '../../services/game_service.dart';

import '../../models/player.dart';

import '../../components/session_browser/session_browser.dart';

@Component(selector: 'game-setup',
    templateUrl: 'game_setup.html',
    styleUrls: const ['game_setup.css'],
    directives: const [CORE_DIRECTIVES, materialDirectives, SessionBrowser]
)
class GameSetup {
  final LoggerService _log;
  final GameService gameService;

  final StreamController<bool> _gameReady = new StreamController<bool>.broadcast();
  @Output() Stream<bool> get gameReady => _gameReady.stream;

  String sessionName;
  String name = "";

  GameSetup(LoggerService this._log, GameService this.gameService) {
    _log.info("$runtimeType()");
  }

  void addPlayer() {
    gameService.addPlayer(name);
    name = "";
  }

//  TODO: Fix the player list so that it updates properly. Adding/removing players isn't reflected in the game, only the setup page.
  void removePlayer(String name) {
    _log.info("$runtimeType():: removePlayer() -- $name");
    gameService.removePlayer(name);
  }

  void startGame() {
    if (gameService.players.isNotEmpty && (sessionName != null && sessionName.isNotEmpty)) {
      gameService.createGame(sessionName);
      _gameReady.add(true);
    }
  }

  void onReorder(ReorderEvent reorder) {
    gameService.players.insert(
        reorder.destIndex, gameService.players.removeAt(reorder.sourceIndex));
    _log.info("$runtimeType()::onReorder() -- ${gameService.players}");
  }
}