import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jotter_mapper/controllers/location_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  static const String name = "Map Screen";
  static const String route = "/map";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? currentLocation;
  bool isLoading = true;
  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    loadCurrentLocation();
    loadMapStyle();
  }

  Future<void> loadCurrentLocation() async {
    await LocationController.I.checkAndRequestPermissions();
    await LocationController.I.getCurrentLocation();
    if (LocationController.I.currentPosition != null) {
      setState(() {
        currentLocation = LatLng(
          LocationController.I.currentPosition!.latitude,
          LocationController.I.currentPosition!.longitude,
        );
        isLoading = false;
      });
    }
  }

  Future<void> loadMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/map_style.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              style: _mapStyle,
              initialCameraPosition:
                  CameraPosition(target: currentLocation!, zoom: 15),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
            ),
    );
  }
}
