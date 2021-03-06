import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';

import '../../services/logger_service.dart';
import '../../services/game_service.dart';

import '../../models/player.dart';

@Component(
    selector: 'game-view',
    templateUrl: 'game_view.html',
    styleUrls: const ['game_view.css'],
    directives: const [
      CORE_DIRECTIVES,
      formDirectives,
      materialDirectives,
      materialNumberInputDirectives
    ])
class GameView implements OnInit{
  final LoggerService _log;
  final GameService _gameService;

  final StreamController<bool> _continueGame = new StreamController<bool>.broadcast();
  @Output() Stream<bool> get continueGame => _continueGame.stream;

  List<Player> players;

  Control scoreInput = new Control();

  num rollResult;

  GameView(LoggerService this._log, GameService this._gameService) {
    _log.info("$runtimeType()");
  }

  ngOnInit() {
    _log.info("$runtimeType()::ngOnInit() -- ${_gameService.orderedPlayers}");
    _gameService.game.newGame();
    players = _gameService.orderedPlayers;
  }

  void endGame() {
    _continueGame.add(false);

    _gameService.endGame();
  }

  void submitScore() {
    _log.info("$runtimeType()::submitScore() - scoreForm control group");

    if (scoreInput.value == null || !scoreInput.valid || _gameService.game.turnsRemaining == 0) {
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
  String get sessionName => _gameService.sessionName;
}
