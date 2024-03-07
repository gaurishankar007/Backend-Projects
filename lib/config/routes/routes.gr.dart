// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:chat/features/auth/presentation/pages/sign_in.dart' as _i6;
import 'package:chat/features/auth/presentation/pages/sign_up.dart' as _i7;
import 'package:chat/features/auth/presentation/pages/update_profile.dart'
    as _i8;
import 'package:chat/features/chat/presentation/pages/chats.dart' as _i1;
import 'package:chat/features/dashboard/presentation/pages/dashboard.dart'
    as _i3;
import 'package:chat/features/dashboard/presentation/pages/settings/dark_mode.dart'
    as _i2;
import 'package:chat/features/dashboard/presentation/pages/settings/setting_dashboard.dart'
    as _i4;
import 'package:chat/features/dashboard/presentation/pages/settings/settings.dart'
    as _i5;
import 'package:flutter/material.dart' as _i10;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    ChatRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.Chats(),
      );
    },
    DarkModeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DarkMode(),
      );
    },
    DashboardRoute.name: (routeData) {
      final args = routeData.argsAs<DashboardRouteArgs>(
          orElse: () => const DashboardRouteArgs());
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.Dashboard(key: args.key),
      );
    },
    SettingDashboardRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SettingDashboard(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.Settings(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SignIn(),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>(
          orElse: () => const SignUpRouteArgs());
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SignUp(key: args.key),
      );
    },
    UpdateProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateProfileRouteArgs>(
          orElse: () => const UpdateProfileRouteArgs());
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.UpdateProfile(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.Chats]
class ChatRoute extends _i9.PageRouteInfo<void> {
  const ChatRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DarkMode]
class DarkModeRoute extends _i9.PageRouteInfo<void> {
  const DarkModeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DarkModeRoute.name,
          initialChildren: children,
        );

  static const String name = 'DarkModeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.Dashboard]
class DashboardRoute extends _i9.PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          DashboardRoute.name,
          args: DashboardRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i9.PageInfo<DashboardRouteArgs> page =
      _i9.PageInfo<DashboardRouteArgs>(name);
}

class DashboardRouteArgs {
  const DashboardRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'DashboardRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.SettingDashboard]
class SettingDashboardRoute extends _i9.PageRouteInfo<void> {
  const SettingDashboardRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingDashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingDashboardRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.Settings]
class SettingRoute extends _i9.PageRouteInfo<void> {
  const SettingRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SignIn]
class SignInRoute extends _i9.PageRouteInfo<void> {
  const SignInRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SignUp]
class SignUpRoute extends _i9.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i9.PageInfo<SignUpRouteArgs> page =
      _i9.PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.UpdateProfile]
class UpdateProfileRoute extends _i9.PageRouteInfo<UpdateProfileRouteArgs> {
  UpdateProfileRoute({
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          UpdateProfileRoute.name,
          args: UpdateProfileRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRoute';

  static const _i9.PageInfo<UpdateProfileRouteArgs> page =
      _i9.PageInfo<UpdateProfileRouteArgs>(name);
}

class UpdateProfileRouteArgs {
  const UpdateProfileRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'UpdateProfileRouteArgs{key: $key}';
  }
}
