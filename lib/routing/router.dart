import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:jotter_mapper/screens/auth/login_screen.dart';
import 'package:jotter_mapper/screens/auth/registration_screen.dart';
import 'package:jotter_mapper/screens/landing_screen.dart';
import 'package:jotter_mapper/screens/on_boarding.dart';

class GlobalRouter {
  static void initialize() {
    GetIt.instance.registerSingleton<GlobalRouter>(GlobalRouter());
  }

  static GlobalRouter get instance => GetIt.instance<GlobalRouter>();
  static GlobalRouter get I => GetIt.instance<GlobalRouter>();

  late GoRouter router;
  late GlobalKey<NavigatorState> _rootNavigatorKey;
  late GlobalKey<NavigatorState> _shellNavigatorKey;

  FutureOr<String?> handleRedirect(BuildContext context, GoRouterState) async {}

  GlobalRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();

    router = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: LandingScreen.route,
        // redirect: handlw,
        routes: [
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: LandingScreen.route,
              name: LandingScreen.name,
              builder: (context, _) {
                return LandingScreen();
              }),
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: OnBoarding.route,
              name: OnBoarding.name,
              builder: (context, _) {
                return OnBoarding();
              }),
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: LoginScreen.route,
              name: LoginScreen.name,
              builder: (context, _) {
                return LoginScreen();
              }),
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: RegistrationScreen.route,
              name: RegistrationScreen.name,
              builder: (context, _) {
                return RegistrationScreen();
              })
        ]);
  }
}
