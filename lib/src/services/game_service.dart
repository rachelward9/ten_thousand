import 'dart:async';

import 'package:angular2/core.dart';

import 'logger_service.dart';
import 'firebase_service.dart';
import '../models/game.dart';
import '../models/player.dart';
import '../models/session.dart';

@Injectable()
class GameService {
  final LoggerService _log;
  final FirebaseService _fbService;
  Game game = new Game();

  List<Player> players = [];
  String sessionRef;

  GameService(LoggerService this._log, FirebaseService this._fbService) {
    _log.info("$runtimeType()");
    game.players = _fbService.players;
  }

  void addPlayer(String name) {
    players.add(new Player(name));
  }

  void removePlayer(String name) {
    game.players.removeWhere((player) => player.name == name);
  }

  void updatePlayer(Player p) {
    try {
      _fbService.fbRefGameSessions.child(sessionRef).child(p.name).update(p.toMap());
    }
    catch (error) {
      _log.info("$runtimeType()::updatePlayer -- $error");
    }
  }

  void createGame(String sessionName) {
    sessionRef = _fbService.createSessionRef();

    _log.info("$runtimeType()::createGame -- $sessionRef");

    Map<String, Map> newPlayers = {};

    players.forEach((p) {
      newPlayers[p.name] = p.toMap();
    });

    _fbService.fbRefGameSessions.child(sessionRef).set(newPlayers);
    _fbService.fbRefGameSessions.child("$sessionRef/name").set(sessionName);
  }

  void endGame() {
    _fbService.fbRefGameSessions.child(sessionRef).remove();
    game.players.forEach((p) {
      p.reset();
    });
    _fbService.players = [];
  }
}