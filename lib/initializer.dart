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

    /// Isar database should be opened before initializing dependencies
    /// Because some auth dependencies require isar instance
    await localDatabaseImplementation.openLocalDatabase();

    initializeDependencies();
    await networkStatus.checkConnectionAndListenConnectivity();
    await userService.initializeUserData();

    _isInitialized = true;
  }
}
