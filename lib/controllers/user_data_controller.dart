import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
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
    String? photoUrl = currentUser?.photoURL;
    await FirebaseAuth.instance.currentUser
        ?.updateProfile(displayName: displayName, photoURL: photoUrl);

    await loadCurrentUser();
  }

  Future<void> updateUserPhotoUrl(String photoUrl) async {
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(photoUrl);
    await loadCurrentUser();
  }

  Future<void> uploadImage(XFile image) async {
    try {
      String userId = currentUser!.uid;
      final ref =
          FirebaseStorage.instance.ref().child('user_photos/$userId.jpg');
      final result = await ref.putFile(File(image.path));
      final photoUrl = await result.ref.getDownloadURL();

      await updateUserPhotoUrl(photoUrl);
    } catch (e) {
      print("Error Uploading Image: $e");
    }
  }
}
