import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthController with ChangeNotifier {
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  static AuthController get instance => GetIt.instance<AuthController>();
  static AuthController get I => GetIt.instance<AuthController>();
}
