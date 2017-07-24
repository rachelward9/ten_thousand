import 'player.dart';

class Game {
  static const int TEN_THOUSAND = 10000;

  List<Player> players = [];

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

//  void addPlayer(String name) {
//    _players.add(new Player(name));
//  }

  void removePlayer(Player player) {
    players.remove(player);
  }

  void nextPlayer() {
    if (turnsRemaining == 0) {
     print("$runtimeType()::nextPlayer() - no turns remaining");
      return;
    }
    if (currentPlayerIndex > -1) {
      winCondition();
      players[currentPlayerIndex].myTurn = false;
    }

    if (++currentPlayerIndex == players.length) {
      currentPlayerIndex = 0;
    }

    players[currentPlayerIndex].myTurn = true;
  }

  void winCondition() {
    int winVal = scoreToBeat ?? TEN_THOUSAND;

    if (players[currentPlayerIndex].score >= winVal) {
      scoreToBeat = players[currentPlayerIndex].score;

      players.forEach((p) {
        p.finalTurn = true;
      });

      finalTurn = true;
    }

    if (finalTurn == true) {
      turnsRemaining--;
    }

    if (!players[currentPlayerIndex].finalTurn) {
      return;
    }
  }
}