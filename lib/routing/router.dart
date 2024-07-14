import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:jotter_mapper/controllers/auth_controller.dart';
import 'package:jotter_mapper/enum/auth_enum.dart';
import 'package:jotter_mapper/screens/auth/login_screen.dart';
import 'package:jotter_mapper/screens/auth/registration_screen.dart';
import 'package:jotter_mapper/screens/content/entries_screen.dart';
import 'package:jotter_mapper/screens/content/home_screen.dart';
import 'package:jotter_mapper/screens/content/map_screen.dart';
import 'package:jotter_mapper/screens/content/profile_screen.dart';
import 'package:jotter_mapper/screens/content/wrapper.dart';
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

  FutureOr<String?> handleRedirect(
      BuildContext context, GoRouterState state) async {
    if (AuthController.I.state == AuthState.authenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return HomeScreen.route;
      }
      if (state.matchedLocation == RegistrationScreen.route) {
        return HomeScreen.route;
      }
      return null;
    }

    if (AuthController.I.state == AuthState.unauthenticated) {
      if (state.matchedLocation == LoginScreen.route) {
        return null;
      }
      if (state.matchedLocation == RegistrationScreen.route) {
        return null;
      }
      return LoginScreen.route;
    }
    return null;
  }

  GlobalRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _shellNavigatorKey = GlobalKey<NavigatorState>();

    router = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: MapScreen.route,
        // redirect: handleRedirect,
        // refreshListenable: AuthController.I,
        routes: [
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: LandingScreen.route,
              name: LandingScreen.name,
              builder: (context, _) {
                return const LandingScreen();
              }),
          GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: OnBoarding.route,
              name: OnBoarding.name,
              builder: (context, _) {
                return const OnBoarding();
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
              }),
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            routes: [
              GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: HomeScreen.route,
                  name: HomeScreen.name,
                  builder: (context, _) {
                    return const HomeScreen();
                  }),
              GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: MapScreen.route,
                  name: MapScreen.name,
                  builder: (context, _) {
                    return const MapScreen();
                  }),
              GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: EntriesScreen.route,
                  name: EntriesScreen.name,
                  builder: (context, _) {
                    return const EntriesScreen();
                  }),
              GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: ProfileScreen.route,
                  name: ProfileScreen.name,
                  builder: (context, _) {
                    return const ProfileScreen();
                  }),
            ],
            builder: (context, state, child) {
              return AppWrapper(
                child: child,
              );
            },
          )
        ]);
  }
}
