import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  NetworkService._();
  static final _singleton = NetworkService._();
  factory NetworkService() => _singleton;

  final Connectivity _connectivity = Connectivity();
  final Stream<ConnectivityResult> _conStream = Connectivity().onConnectivityChanged;
  StreamSubscription<ConnectivityResult>? _subscription;
  bool _online = true;
  bool get online => _online;

  init() async {
    if (_subscription != null) return;
    _changeStatus(await _connectivity.checkConnectivity());
    _subscription = _conStream.listen((event) => _changeStatus(event));
  }

  _changeStatus(ConnectivityResult result) {
    bool isOnline = result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
    if (isOnline) return _online = true;
    _online = false;
  }

  void get cancelSub => _subscription?.cancel();

  Stream<bool> streamNetwork(StreamController<bool> ctr) async* {
    _connectivity.onConnectivityChanged.listen((event) {
      bool isOnline = event == ConnectivityResult.mobile || event == ConnectivityResult.wifi;
      if (isOnline) return ctr.add(true);
      ctr.add(false);
    });

    yield* ctr.stream;
  }
}
