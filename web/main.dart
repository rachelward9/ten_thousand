import 'package:angular2/angular2.dart';
import 'package:angular2/platform/browser.dart';

import 'package:ten_thousand_ng/app_component.dart';
import 'package:ten_thousand_ng/src/services/logger_service.dart';
import 'package:ten_thousand_ng/src/services/firebase_service.dart';

const String APP_NAME = "Ten Thousand";
final LoggerService _log = new LoggerService(appName: APP_NAME);

void main() {
  bootstrap(AppComponent, [
    provide(LoggerService, useValue: _log),
    provide(FirebaseService),
  ]);
}
