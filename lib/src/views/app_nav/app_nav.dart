import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../services/logger_service.dart';
import '../../services/firebase_service.dart';

@Component(selector: 'app-nav',
    templateUrl: 'app_nav.html',
    styleUrls: const['app_nav.css'],
    directives: const [CORE_DIRECTIVES, materialDirectives]
)
class AppNav {
  final LoggerService _log;
  final FirebaseService fbService;

  bool showMenuPopup = false;

  AppNav(this._log, this.fbService) {
    _log.info("$runtimeType()");
  }
}