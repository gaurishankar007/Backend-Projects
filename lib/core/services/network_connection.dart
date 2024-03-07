import 'dart:async' show StreamSubscription;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class NetworkConnection {
  NetworkConnection._();
  static final _singleton = NetworkConnection._();
  factory NetworkConnection() => _singleton;

  final Connectivity _connectivity = Connectivity();
  final Stream<ConnectivityResult> _connectivityStream = Connectivity().onConnectivityChanged;
  StreamSubscription<ConnectivityResult>? _subscription;
  bool _online = true;
  bool get isOnline => _online;

  _changeStatus(ConnectivityResult result) =>
      _online = result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;

  /// Listen to the network connections
  /// Changes _online variable value according the network status
  checkConnection() async {
    if (_subscription != null) return;

    /// Do manual checking for web version
    if (kIsWeb) _changeStatus(await _connectivity.checkConnectivity());
    _subscription = _connectivityStream.listen((event) => _changeStatus(event));
  }

  /// Stop listening to the network status changes
  cancelSubscription() {
    if (_subscription != null) _subscription!.cancel();
  }
}
