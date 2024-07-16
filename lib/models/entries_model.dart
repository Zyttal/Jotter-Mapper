import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class Entry {
  String entryId;
  final String userId;
  final String title;
  final String date;
  final List<String>? imageUrls;
  final LatLng location;
  final String? subtitle;
  final String content;
  final String locationName;

  Entry({
    required this.entryId,
    required this.userId,
    required this.title,
    required this.date,
    required this.imageUrls,
    required this.location,
    required this.subtitle,
    required this.content,
    required this.locationName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'date': date,
      'imageUrls': imageUrls,
      'location': GeoPoint(location.latitude, location.longitude),
      'subtitle': subtitle,
      'content': content,
      'locationName': locationName,
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map, String id) {
    return Entry(
      entryId: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      location: LatLng(
        (map['location'] as GeoPoint).latitude,
        (map['location'] as GeoPoint).longitude,
      ),
      subtitle: map['subtitle'],
      content: map['content'] ?? '',
      locationName: map['locationName'] ?? '',
    );
  }

  static String formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }
}
