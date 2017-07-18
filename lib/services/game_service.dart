import 'package:angular2/core.dart';

import 'logger_service.dart';
import '../models/game.dart';

@Injectable()
class GameService {
  final LoggerService _log;
  Game game = new Game();

  GameService(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}