import '../services/logger_service.dart';

import 'player.dart';

class Game {
  final LoggerService _log = new LoggerService();
  final List<Player> _players = [];
  static const int TEN_THOUSAND = 10000;

  int currentPlayerIndex;
  int scoreToBeat;
  bool finalTurn;

  void newGame() {
    currentPlayerIndex = -1;
    scoreToBeat = null;
    nextPlayer();
  }

  void addPlayer(String name) {
    _players.add(new Player(name));
  }

  void removePlayer(Player player) {
    _players.remove(player);
  }

  void nextPlayer() {
    if (currentPlayerIndex > -1 && !_players[currentPlayerIndex].finalTurn) {
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
      scoreToBeat = winVal;
      finalTurn = true;
      print("You're winning! Score to beat is now $scoreToBeat.");
    }
    else if (!_players[currentPlayerIndex].finalTurn) {
      return;
    }
    else {
      print("${players[currentPlayerIndex].name} loses.");
    }
  }

  List<Player> get players => _players;
}