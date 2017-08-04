import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import '../../services/logger_service.dart';
import '../../services/game_service.dart';

import '../../models/player.dart';

@Component(
    selector: 'game-view',
    templateUrl: 'game_view.html',
    directives: const [
      CORE_DIRECTIVES,
      FORM_DIRECTIVES,
      materialDirectives,
      materialNumberInputDirectives
    ])
class GameView {
  final LoggerService _log;
  final GameService _gameService;

  final StreamController<bool> _continueGame = new StreamController<bool>.broadcast();
  @Output() Stream<bool> get continueGame => _continueGame.stream;

  Control scoreInput = new Control();

  num rollResult;

  GameView(LoggerService this._log, GameService this._gameService) {
    _log.info("$runtimeType()");
    _gameService.game.newGame();
  }

  void endGame() {
    _continueGame.add(false);

    _gameService.endGame();
  }

//  TODO: Fix final turn, because it doesn't properly finish a round.
  void submitScore() {
    _log.info("$runtimeType()::submitScore() - scoreForm control group");

    if (scoreInput.value == null || !scoreInput.valid || _gameService.game.players[_gameService.game.currentPlayerIndex].finalTurn == true) {
      return;
    }

    _gameService.game.players[_gameService.game.currentPlayerIndex].addDiceResult(scoreInput.value.toInt());
    _gameService.updatePlayer(_gameService.game.players[_gameService.game.currentPlayerIndex]);

    scoreInput.updateValue(null);
    _gameService.game.nextPlayer();
  }

  void bust() {
    _gameService.game.players[_gameService.game.currentPlayerIndex].bustCount++;
    _gameService.game.nextPlayer();
  }

  Player get currentPlayer => _gameService.game.players[_gameService.game.currentPlayerIndex];

  List<Player> get players => _gameService.game.players;
}