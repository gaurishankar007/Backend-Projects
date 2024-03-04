import 'package:flutter/services.dart';
import 'package:flutter/material.dart' show WidgetsBinding;

import 'core/resources/data_state.dart';
import 'features/auth/injection/auth_injector.dart';

import 'features/auth/data/models/userData/user_data_model.dart';
import 'injection/injector.dart';

class AppData {
  AppData._();
  static final _singleton = AppData._();
  factory AppData() => _singleton;

  final _flutterView = WidgetsBinding.instance.platformDispatcher.views.first;
  bool _isTablet = false;
  UserDataModel? _userData;

  Future<void> initialize() async {
    double shortestSide = _flutterView.physicalSize.shortestSide / _flutterView.devicePixelRatio;
    _isTablet = shortestSide > 600;
    final orientation = _isTablet ? DeviceOrientation.landscapeLeft : DeviceOrientation.portraitUp;
    SystemChrome.setPreferredOrientations([orientation]);

    initializeDependencies();
    await network.checkConnection();
    await _authenticate();
  }

  _authenticate() async {
    final dataState = await getUserDataUseCase.call();
    if (dataState is DataSuccessSate) _userData = dataState.data!;
  }

  /// Setters
  set userData(UserDataModel userData) => _userData = userData;

  /// Getters
  bool get isTablet => _isTablet;
  bool get isLoggedIn => _userData != null;
  UserDataModel get userData => _userData!;
}
