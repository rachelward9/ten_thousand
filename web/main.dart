import 'package:angular2/angular2.dart';
import 'package:angular2/platform/browser.dart';

import 'package:ten_thousand_ng/views/app_component/app_component.dart';
import 'package:ten_thousand_ng/services/logger_service.dart';

const String APP_NAME = "Ten Thousand";
final LoggerService _log = new LoggerService(appName: APP_NAME);

void main() {
  bootstrap(AppComponent, [
    provide(LoggerService, useValue: _log)
  ]);
}
