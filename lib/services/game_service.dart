import 'package:angular2/core.dart';

import 'logger_service.dart';
import 'firebase_service.dart';
import '../models/game.dart';

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
}