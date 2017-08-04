class Player {
  final String name;

  int _score;
  int _lastDiceResult;
  int bustCount;
  bool myTurn;
  bool finalTurn;

  Player(this.name, [this._score, this._lastDiceResult, this.bustCount, this.myTurn, this.finalTurn]) {
    reset();
  }

  Player.fromMap(Map map) : this(map['name'], map['_score'], map['_lastDiceResult'], map['bustCount'], map['myTurn'], map['finalTurn']);

  Map toMap() => {
    "name" : name,
    "_score" : _score,
    "_lastDiceResult" : _lastDiceResult,
    "bustCount" : bustCount,
    "myTurn" : myTurn,
    "finalTurn" : finalTurn
  };

  void reset() {
    _score = 0;
    _lastDiceResult = null;
    bustCount = 0;
    myTurn = false;
    finalTurn = false;
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