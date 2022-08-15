import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.dart';
import 'configs/flavor_config.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlavorConfig(
      flavor: Flavor.staging,
      values: FlavorValues(baseUrl: 'https://abc.com/api'));
  FlutterNativeSplash.remove();

  runApp(const App());
}
