// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/cupertino.dart' as _i4;
import 'package:flutter/material.dart' as _i3;

import '../../data/models/menfess/menfess_model.dart' as _i5;
import '../pages/screens.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    FessFormRoute.name: (routeData) {
      final args = routeData.argsAs<FessFormRouteArgs>(
          orElse: () => const FessFormRouteArgs());
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.FessFormPage(
          key: args.key,
          menfessModel: args.menfessModel,
          isReply: args.isReply,
        ),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    FessDetailRoute.name: (routeData) {
      final args = routeData.argsAs<FessDetailRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.FessDetailPage(
          key: args.key,
          menfessModel: args.menfessModel,
        ),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        _i2.RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        _i2.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i2.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i2.RouteConfig(
          FessFormRoute.name,
          path: '/fess-form',
        ),
        _i2.RouteConfig(
          FessDetailRoute.name,
          path: '/fess-detail',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i2.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.FessFormPage]
class FessFormRoute extends _i2.PageRouteInfo<FessFormRouteArgs> {
  FessFormRoute({
    _i4.Key? key,
    _i5.MenfessModel? menfessModel,
    bool isReply = false,
  }) : super(
          FessFormRoute.name,
          path: '/fess-form',
          args: FessFormRouteArgs(
            key: key,
            menfessModel: menfessModel,
            isReply: isReply,
          ),
        );

  static const String name = 'FessFormRoute';
}

class FessFormRouteArgs {
  const FessFormRouteArgs({
    this.key,
    this.menfessModel,
    this.isReply = false,
  });

  final _i4.Key? key;

  final _i5.MenfessModel? menfessModel;

  final bool isReply;

  @override
  String toString() {
    return 'FessFormRouteArgs{key: $key, menfessModel: $menfessModel, isReply: $isReply}';
  }
}

/// generated route for
/// [_i1.FessDetailPage]
class FessDetailRoute extends _i2.PageRouteInfo<FessDetailRouteArgs> {
  FessDetailRoute({
    _i4.Key? key,
    required _i5.MenfessModel menfessModel,
  }) : super(
          FessDetailRoute.name,
          path: '/fess-detail',
          args: FessDetailRouteArgs(
            key: key,
            menfessModel: menfessModel,
          ),
        );

  static const String name = 'FessDetailRoute';
}

class FessDetailRouteArgs {
  const FessDetailRouteArgs({
    this.key,
    required this.menfessModel,
  });

  final _i4.Key? key;

  final _i5.MenfessModel menfessModel;

  @override
  String toString() {
    return 'FessDetailRouteArgs{key: $key, menfessModel: $menfessModel}';
  }
}
