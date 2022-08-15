
import '../../app_isolate/worker.dart';

class AppManager{
  static AppManager shared = AppManager();
  late Worker worker;
}

