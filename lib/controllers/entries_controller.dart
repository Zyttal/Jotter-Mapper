import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jotter_mapper/controllers/user_data_controller.dart';
import 'package:jotter_mapper/models/entries_model.dart';

class EntriesController with ChangeNotifier {
  List<Entry> entries = [];

  static void initialize() {
    GetIt.instance.registerSingleton<EntriesController>(EntriesController());
  }

  static EntriesController get instance => GetIt.instance<EntriesController>();
  static EntriesController get I => GetIt.instance<EntriesController>();

  Future<void> fetchEntries(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("entries")
          .where('userId', isEqualTo: userId)
          .get();
      entries = querySnapshot.docs.map((doc) {
        return Entry.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      notifyListeners();
    } catch (e) {
      print("Error fetching entries: $e");
    }
  }

  Future<void> addEntry(Entry entry) async {
    try {
      final docref = await FirebaseFirestore.instance
          .collection('entries')
          .add(entry.toMap());
      entry.entryId = docref.id;

      entries.add(entry);
      notifyListeners();
    } catch (e) {
      print("Error adding entry: $e");
    }
  }

  Future<void> uploadEntry({
    required String title,
    String? subtitle,
    required String content,
    required LatLng location,
    required String locationName,
    List<XFile>? images,
  }) async {
    try {
      final userId = UserDataController.I.currentUser!.uid;
      List<String>? imageUrls;

      print("These are the images passed: $images");

      if (images != null && images.isNotEmpty) {
        imageUrls = [];
        for (var image in images) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('user_photos/entries/${image.name}');
          await ref.putFile(File(image.path));
          final imageUrl = await ref.getDownloadURL();
          imageUrls.add(imageUrl);
        }
      }
      print(imageUrls);

      final newEntry = Entry(
          entryId: '',
          userId: userId,
          title: title,
          date: Entry.formatDate(DateTime.now()),
          imageUrls: imageUrls,
          location: location,
          subtitle: subtitle,
          content: content,
          locationName: locationName);

      await addEntry(newEntry);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> deleteEntry(String entryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('entries')
          .doc(entryId)
          .delete();

      entries.removeWhere((entry) => entry.entryId == entryId);

      notifyListeners();
    } catch (e) {
      print("Error Deleting entry: $e");
    }
  }
}
