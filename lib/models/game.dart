import '../services/logger_service.dart';

import 'player.dart';

class Game {
  final LoggerService _log = new LoggerService();
  final List<Player> _players = [];
  static const int TEN_THOUSAND = 10000;

  int currentPlayerIndex;
  int scoreToBeat;
  int turnsRemaining;
  bool finalTurn;

  void newGame() {
    currentPlayerIndex = -1;
    scoreToBeat = null;
    turnsRemaining = players.length;
    nextPlayer();
  }

  void addPlayer(String name) {
    _players.add(new Player(name));
  }

  void removePlayer(Player player) {
    _players.remove(player);
  }

  void nextPlayer() {
    if (turnsRemaining == 0) {
      _log.info("$runtimeType()::nextPlayer() - no turns remaining");
      return;
    }
    if (currentPlayerIndex > -1) {
      winCondition();
      _players[currentPlayerIndex].myTurn = false;
    }

    if (++currentPlayerIndex == players.length) {
      currentPlayerIndex = 0;
    }

    _players[currentPlayerIndex].myTurn = true;
  }

  void winCondition() {
    int winVal = scoreToBeat ?? TEN_THOUSAND;

    if (_players[currentPlayerIndex].score >= winVal) {
      scoreToBeat = _players[currentPlayerIndex].score;

      players.forEach((p) {
        p.finalTurn = true;
      });

      finalTurn = true;
    }

    if (finalTurn == true) {
      turnsRemaining--;
    }

    if (!_players[currentPlayerIndex].finalTurn) {
      return;
    }
  }

  List<Player> get players => _players;
}