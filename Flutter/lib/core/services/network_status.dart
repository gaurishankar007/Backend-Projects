import 'dart:async' show StreamSubscription;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Check whether the device is online or offline
class NetworkStatus {
  final InternetConnectionChecker internetConnectionChecker;
  final Connectivity _connectivity;

  NetworkStatus({required this.internetConnectionChecker, required Connectivity connectivity})
      : _connectivity = connectivity;

  StreamSubscription<ConnectivityResult>? _subscription;
  bool _connection = true;
  bool get hasConnection => _connection;

  Future<bool> checkConnection() async => await internetConnectionChecker.hasConnection;

  /// Checks weather internet is available or not and listens to the connectivity changes
  checkConnectionAndListenConnectivity() async {
    if (_subscription != null) return;

    /// Do manual checking for web version
    _connection = await checkConnection();

    /// Listen to connectivity changes
    _subscription = _connectivity.onConnectivityChanged.listen((status) async {
      if (status != ConnectivityResult.none) {
        _connection = await checkConnection();
      } else {
        _connection = false;
      }
    });
  }

  /// Stop listening to the connectivity changes
  cancelSubscription() {
    if (_subscription != null) _subscription!.cancel();
  }
}
