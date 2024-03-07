import 'package:flutter/material.dart' show WidgetsFlutterBinding;

import 'injection/injector.dart';

class AppInitializer {
  AppInitializer._();
  static final _singleton = AppInitializer._();
  factory AppInitializer() => _singleton;

  bool _isInitialized = false;

  Future initialize() async {
    if (_isInitialized) return;

    WidgetsFlutterBinding.ensureInitialized();
    initializeDependencies();
    await network.checkConnection();
    await userService.initializeUserData();

    _isInitialized = true;
  }
}
