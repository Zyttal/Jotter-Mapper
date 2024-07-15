import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEntryScreen extends StatelessWidget {
  static const String name = "Add Entry Screen";
  static const String route = "/add-entry";

  const AddEntryScreen({super.key, required this.location});
  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("LAT: ${location.latitude} LONG: ${location.longitude}"),
      ),
    );
  }
}
