import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jotter_mapper/static_data.dart';

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
        return Entry.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      notifyListeners();
    } catch (e) {
      print("Error fetching entries: $e");
    }
  }

  Future<void> addEntry(Entry entry) async {
    try {
      await FirebaseFirestore.instance
          .collection('entries')
          .doc(entry.entryId)
          .set(entry.toMap());

      entries.add(entry);
      notifyListeners();
    } catch (e) {
      print("Error adding entry: $e");
    }
  }
}
