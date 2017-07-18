import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import '../../services/logger_service.dart';
import '../../services/game_service.dart';

import '../../models/player.dart';

@Component(selector: 'game-view',
    templateUrl: 'game_view.html',
    directives: const [CORE_DIRECTIVES, materialDirectives]
)
class GameView {
  final LoggerService _log;
  final GameService _game;

  final StreamController<bool> _continueGame = new StreamController<bool>.broadcast();
  @Output() Stream<bool> get continueGame => _continueGame.stream;

  String rollResult = "0";

  GameView(LoggerService this._log, GameService this._game) {
    _log.info("$runtimeType()");
    _game.game.newGame();
  }

  void stop() {
    _continueGame.add(false);
    _game.game.players.forEach((Player p) {
      p.reset();
    });
  }

  void next() {
    _game.game.players[_game.game.currentPlayerIndex].addDiceResult(int.parse(rollResult));
    rollResult = "0";
    _game.game.nextPlayer();
  }

  String get currentPlayer => _game.game.players[_game.game.currentPlayerIndex].name;

  List<Player> get players => _game.game.players;
}