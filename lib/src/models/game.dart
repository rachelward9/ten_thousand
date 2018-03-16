import 'player.dart';

class Game {
  static const int TEN_THOUSAND = 10000;

  List<Player> players = [];
  int currentPlayerIndex;
  int scoreToBeat;
  int turnsRemaining;
  bool finalTurn;
  Player winner;

  void newGame() {
    currentPlayerIndex = -1;
    scoreToBeat = null;
    turnsRemaining = players.length;
    nextPlayer();
  }

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

      finalTurn = true;
      List<Player> scoreOrder = new List.from(players);
      scoreOrder.sort((Player a, Player b) => b.score.compareTo(a.score));
      winner = scoreOrder.first;
    }

    if (finalTurn == true) {
      turnsRemaining--;
    }
  }
}