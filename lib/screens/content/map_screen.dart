import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jotter_mapper/controllers/entries_controller.dart';
import 'package:jotter_mapper/controllers/location_controller.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/widgets/entry_dialog.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  static const String name = "Map Screen";
  static const String route = "/map";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;
  LatLng? currentLocation;
  bool isLoading = true;
  String? _mapStyle;
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    loadCurrentLocation();
    loadMapStyle();
    initializeMarkers();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
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

  void initializeMarkers() {
    for (var entry in EntriesController.I.entries) {
      final marker = Marker(
        markerId: MarkerId(entry.entryId),
        position: entry.location,
        onTap: () => showEntryDialog(context, entry),
        icon: BitmapDescriptor.defaultMarker,
      );

      _markers.add(marker);
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
              child: SpinKitChasingDots(
                color: ColorPalette.primary100,
              ),
            )
          : GoogleMap(
              style: _mapStyle,
              initialCameraPosition:
                  CameraPosition(target: currentLocation!, zoom: 15),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(_markers),
              onTap: (LatLng tappedLocation) {
                addEntryDialog(context, tappedLocation);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
    );
  }
}
