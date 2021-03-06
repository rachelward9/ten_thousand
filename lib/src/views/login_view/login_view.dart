import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../services/logger_service.dart';
import '../../services/firebase_service.dart';


@Component(selector: 'login-view',
    templateUrl: 'login_view.html',
    styleUrls: const ['login_view.css'],
    directives: const [materialDirectives],
    providers: const []
)
class LoginView {
  final LoggerService _log;
  final FirebaseService fbService;

  LoginView(LoggerService this._log, this.fbService) {
    _log.info("$runtimeType()");
  }
}