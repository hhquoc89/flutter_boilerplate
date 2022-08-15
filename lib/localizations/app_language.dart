import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../configs/constants.dart';

class AppLanguage {
  late Locale currentLocale;

  final _storage = const FlutterSecureStorage();

  Future<void> fetchLocale() async {
    final locale = await _storage.read(key: KeyStores.userLocale);
    if (locale == null) {
      currentLocale = const Locale("en", "US");
    } else {
      final splitData = locale.split("_");
      currentLocale = Locale(splitData.first, splitData.last);
    }
  }

  Future<void> changeLanguage(String locale) async {
    final splitData = locale.split("_");
    currentLocale = Locale(splitData.first, splitData.last);
    await _storage.write(
        key: KeyStores.userLocale, value: currentLocale.toString());
  }
}
