import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.dart';
import 'app_isolate/worker.dart';
import 'commons/utils/app_manager.dart';
import 'configs/flavor_config.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  FlavorConfig(
      flavor: Flavor.dev, values: FlavorValues(baseUrl: 'https://abc.com/api'));
  AppManager.shared.worker = Worker();
  await AppManager.shared.worker.init();
  FlutterNativeSplash.remove();
  runApp(const App());
}
