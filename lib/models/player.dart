class Player {
  final String name;

  int _score = 0;
  int _lastDiceResult;
  bool myTurn;
  bool finalTurn;

  Player(this.name) {
    reset();
  }

  void reset() {
    _score = 0;
    _lastDiceResult = null;
    myTurn = false;
  }

  void addDiceResult(int value) {
    _lastDiceResult = value;
    _score += value;
  }

  void undo() {
    _score -= _lastDiceResult;
    _lastDiceResult = null;
  }

  int get score => _score;

//  UI will handle this. If canUndo is false, the button is disabled.
  bool get canUndo => _lastDiceResult != null;

  @override String toString() => "$name: $_score";
}