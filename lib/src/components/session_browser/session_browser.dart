import 'package:angular/angular.dart';

import '../../services/logger_service.dart';
import '../../services/firebase_service.dart';

import '../../models/session.dart';

@Component(
    selector: 'session-browser',
    templateUrl: 'session_browser.html',
    directives: const [COMMON_DIRECTIVES]
)
class SessionBrowser {
  final LoggerService _log;
  final FirebaseService _fbService;

  List<Session> existingSessions;

  SessionBrowser(LoggerService this._log, FirebaseService this._fbService) {
    _log.info("$runtimeType()");

    existingSessions = _fbService.sessions;
  }

//  TODO: Make sessions clickable (to join)
  void joinGame() {

  }
}
