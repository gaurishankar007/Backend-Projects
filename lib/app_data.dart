import 'package:chat/injection/injector.dart';

class AppData {
  AppData._();
  static final _singleton = AppData._();
  factory AppData() => _singleton;

  Future<void> init() async {
    initDep();
  }
}
