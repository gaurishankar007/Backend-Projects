// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:chat/features/auth/presentation/pages/sign_in.dart' as _i3;
import 'package:chat/features/auth/presentation/pages/sign_up.dart' as _i4;
import 'package:chat/features/auth/presentation/pages/update_profile.dart'
    as _i5;
import 'package:chat/features/chat/presentation/pages/chats.dart' as _i1;
import 'package:chat/features/dashboard/presentation/pages/dashboard.dart'
    as _i2;
import 'package:flutter/material.dart' as _i7;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    ChatRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.Chats(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.Dashboard(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SignIn(),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>(
          orElse: () => const SignUpRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.SignUp(key: args.key),
      );
    },
    UpdateProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateProfileRouteArgs>(
          orElse: () => const UpdateProfileRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.UpdateProfile(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.Chats]
class ChatRoute extends _i6.PageRouteInfo<void> {
  const ChatRoute({List<_i6.PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.Dashboard]
class DashboardRoute extends _i6.PageRouteInfo<void> {
  const DashboardRoute({List<_i6.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SignIn]
class SignInRoute extends _i6.PageRouteInfo<void> {
  const SignInRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SignUp]
class SignUpRoute extends _i6.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i6.PageInfo<SignUpRouteArgs> page =
      _i6.PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.UpdateProfile]
class UpdateProfileRoute extends _i6.PageRouteInfo<UpdateProfileRouteArgs> {
  UpdateProfileRoute({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          UpdateProfileRoute.name,
          args: UpdateProfileRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRoute';

  static const _i6.PageInfo<UpdateProfileRouteArgs> page =
      _i6.PageInfo<UpdateProfileRouteArgs>(name);
}

class UpdateProfileRouteArgs {
  const UpdateProfileRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'UpdateProfileRouteArgs{key: $key}';
  }
}
