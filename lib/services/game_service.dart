import 'dart:async';

import 'package:angular2/core.dart';

import 'logger_service.dart';
import 'firebase_service.dart';
import '../models/game.dart';
import '../models/player.dart';

@Injectable()
class GameService {
  final LoggerService _log;
  final FirebaseService _fbService;
  Game game = new Game();

  GameService(LoggerService this._log, FirebaseService this._fbService) {
    _log.info("$runtimeType()");
    game.players = _fbService.players;
  }

  void addPlayer(String name) {
    _fbService.addPlayer(name);
  }

  void updatePlayer({String name, int score}) {
    _fbService.updatePlayer(name: name, score: score);
  }

  void updateTest(Player p) {
    _fbService.testUpdate(p);
  }

  void createGame(List<String> playerNames) {
    String sessionRef = _fbService.createSessionRef();
    List<Player> players = [];

    _log.info("$runtimeType()::createGame -- $sessionRef");
    playerNames.forEach((name) {
      players.add(new Player(name));
    });

    var newPlayers = {};

    players.forEach((p) {
      newPlayers[p.name] = p.toMap();
    });

    _fbService.fbRefGameSessions.child(sessionRef).update(newPlayers);
  }
}