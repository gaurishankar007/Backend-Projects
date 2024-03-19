import 'package:flutter/material.dart' show WidgetsFlutterBinding;

import 'injection/injector.dart';

class Initializer {
  Initializer._();
  static final _singleton = Initializer._();
  factory Initializer() => _singleton;

  bool _isInitialized = false;

  Future initialize() async {
    if (_isInitialized) return;

    WidgetsFlutterBinding.ensureInitialized();

    initializeDependencies();
    await localDatabase.open();
    await networkStatus.checkConnectionAndListenConnectivity();
    await userService.initializeUserData();

    _isInitialized = true;
  }
}
