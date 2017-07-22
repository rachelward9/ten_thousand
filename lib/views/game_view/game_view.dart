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
  final GameService _game;

  final StreamController<bool> _continueGame = new StreamController<bool>.broadcast();
  @Output() Stream<bool> get continueGame => _continueGame.stream;

  @ViewChild('nextBtn') MaterialFabComponent nextBtn;

  num rollResult;

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

//  TODO: More intense parsing. This will crash if someone enters an invalid character. Ooo... input?
  void next(Map scoreInput) {
    _log.info("$runtimeType()::next() - rollResult: $rollResult");
    _log.info("$runtimeType()::next() - scoreInput: $scoreInput");

    if (rollResult != null) {
      _game.game.players[_game.game.currentPlayerIndex].addDiceResult(rollResult.toInt());
      rollResult = null;
      _game.game.nextPlayer();
    }

    nextBtn.focus();
  }

  Player get currentPlayer =>
      _game.game.players[_game.game.currentPlayerIndex];

  List<Player> get players => _game.game.players;

  Map<String, bool> controlStateClasses(NgControl control) => {
        'ng-dirty': control.dirty ?? false,
        'ng-pristine': control.pristine ?? false,
        'ng-touched': control.touched ?? false,
        'ng-untouched': control.untouched ?? false,
        'ng-valid': control.valid ?? false,
        'ng-invalid': control.valid == false
      };
}
