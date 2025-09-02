import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:get_it/get_it.dart';

import 'core/services/local_database.dart';
import 'core/services/network_status.dart';
import 'core/services/user_service.dart';
import 'injector/injector.dart';

class Initializer {
  static bool _isInitialized = false;

  static Future initializeApp() async {
    if (_isInitialized) return;

    WidgetsFlutterBinding.ensureInitialized();

    initializeDependencies();
    await GetIt.I<LocalDatabase>().open();
    await GetIt.I<NetworkStatus>().checkConnectionAndListenConnectivity();
    await GetIt.I<UserService>().initializeUserData();

    _isInitialized = true;
  }
}
