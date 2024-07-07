import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jotter_mapper/controllers/user_data_controller.dart';
import 'package:jotter_mapper/enum/auth_enum.dart';
import 'package:jotter_mapper/services/firebase_services.dart';

class AuthController with ChangeNotifier {
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
    UserDataController.initialize();
  }

  static AuthController get instance => GetIt.instance<AuthController>();
  static AuthController get I => GetIt.instance<AuthController>();

  late StreamSubscription<User?> currentAuthedUser;
  AuthState state = AuthState.unauthenticated;

  UserDataController? _userDataController;

  UserDataController get userDataController {
    _userDataController ??= UserDataController();

    if (_userDataController == null &&
        FirebaseAuth.instance.currentUser != null) {
      _userDataController = UserDataController();
    }
    return _userDataController!;
  }

  listen() {
    currentAuthedUser =
        FirebaseAuth.instance.authStateChanges().listen(handleUserChanges);
  }

  login(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  logout() {
    return FirebaseAuth.instance.signOut();
  }

  register(String email, String password, String displayName) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await FirebaseAuth.instance.currentUser
        ?.updateProfile(displayName: displayName);
  }

  handleUserChanges(User? user) {
    if (user == null) {
      state = AuthState.unauthenticated;
      _userDataController = null;
    } else {
      state = AuthState.authenticated;

      _userDataController ??= UserDataController();
      _userDataController?.loadCurrentUser();

      // print("Email Address: ${_userDataController?.currentUser?.email}");
      // print("Display Name: ${_userDataController?.currentUser?.displayName}");
      // print("Photo URL: ${_userDataController?.currentUser?.photoURL}");

      FireStoreServices.storeUser(user.email ?? "No email available", user.uid);
    }
    notifyListeners();
  }

  loadSession() async {
    listen();
    User? user = FirebaseAuth.instance.currentUser;
    handleUserChanges(user);
  }
}
