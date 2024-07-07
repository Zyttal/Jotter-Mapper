import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jotter_mapper/controllers/auth_controller.dart';
import 'package:jotter_mapper/models/user_model.dart';
import 'package:jotter_mapper/services/firebase_services.dart';

class UserDataController with ChangeNotifier {
  UserModel? currentUser;

  static void initialize() {
    GetIt.instance.registerSingleton<UserDataController>(UserDataController());
  }

  static UserDataController get instance =>
      GetIt.instance<UserDataController>();
  static UserDataController get I => GetIt.instance<UserDataController>();

  Future<void> loadCurrentUser() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      currentUser = UserModel.fromFirebaseUser(firebaseUser);
      await FireStoreServices.getUser(currentUser!.uid);
    } else {
      currentUser = null;
    }
    notifyListeners();
  }

  Future<void> updateDisplayName(String displayName) async {
    await FirebaseAuth.instance.currentUser
        ?.updateProfile(displayName: displayName);
    notifyListeners();
  }
}
